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

          o.on "-V", "--version", "Print the version information" do
            puts "secret_santa_picker version #{SecretSantaPicker::VERSION}"
            exit 0
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
