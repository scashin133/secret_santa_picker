require 'mail'
require 'csv'

require 'secret_santa_picker/person'

module SecretSantaPicker
  class Processor
    def initialize(conf)
      @conf = conf
    end

    def run
      pairs.each { |pair| send_mail(pair: pair) }
    end

    private

    def send_mail(pair:)
      mail = Mail.new do
        from     @conf.sender_email
        to       pair.from.email
        subject  "Cashin Family Secret Santa #{Date.today.strftime('%Y')}"
        body     "Hey #{pair.from.name},\n\nYou are the secret Santa for #{pair.to.name}.\n\nGood Luck!"
      end

      $stdout.puts(mail) && return if @conf.debug

      mail.delivery_method :smtp, address: 'smtp.gmail.com',
                                  port: 587,
                                  user_name: @conf.sender_email,
                                  password: @conf.sender_password,
                                  authentication: :plain,
                                  enable_starttls_auto: true
      mail.deliver
    end

    def pairs
      return @pairs if defined?(@pairs)

      array_of_arrays = CSV.read(@conf.csv_file_path)
      persons = Person.generate(csv_array: array_of_arrays)

      @pairs = Pair.generate(persons: persons)
    end
  end
end
