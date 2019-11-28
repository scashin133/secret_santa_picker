require 'mail'
require 'csv'

require 'secret_santa_picker/person'
require 'secret_santa_picker/pair'

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
      sender_email = @conf.sender_email

      subject = [@conf.subject_prefix, "Secret Santa #{Date.today.strftime('%Y')}"].compact.join(" ")
      mail = Mail.new do
        from     sender_email
        to       pair.from.email
        subject  subject
        body     "Hey #{pair.from.name},\n\nYou are the secret Santa for #{pair.to.name}.\n\nGood Luck!"
      end

      if @conf.debug
        $stdout.puts(mail)
        return
      end

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
