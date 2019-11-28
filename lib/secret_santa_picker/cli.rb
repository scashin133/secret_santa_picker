require 'optparse'

require 'secret_santa_picker'
require 'secret_santa_picker/const'
require 'secret_santa_picker/configuration'
require 'secret_santa_picker/processor'

module SecretSantaPicker
  class Cli
    def initialize(argv)
      @argv = argv.dup
      @conf = nil
      @parser = nil
      setup_options

      begin
        @parser.parse! @argv
      rescue UnsupportedOption
        exit 1
      end

      @processor = SecretSantaPicker::Processor.new(@conf)
    end

    def run
      @processor.run
    end

    def setup_options
      @conf = Configuration.new do |config|
        @parser = OptionParser.new do |o|
          o.on "-c", "--csv-file PATH", "Load csv file as participants in secret santa" do |arg|
            config.csv_file_path = arg
          end

          o.on "-s", "--sender-email EMAIL", "Who to send email from" do |arg|
            config.sender_email = arg
          end

          o.on "-p", "--sender-password PASSWORD", "The password for email account being used to send email" do |arg|
            config.sender_password = arg
          end

          o.on "-d", "--debug", "Will disable external communication" do |d|
            config.debug = d
          end

          o.on "-V", "--version", "Print the version information" do
            puts "secret_santa_picker version #{SecretSantaPicker::VERSION}"
            exit 0
          end

          o.on "-x", "--subject-prefix", "Prepend to the Subject line a little additional message" do |arg|
            config.subject_prefix = arg
          end

          o.banner = "secret_santa_picker <options>"

          o.on_tail "-h", "--help", "Show help" do
            $stdout.puts o
            exit 0
          end
        end
      end
    end
  end
end
