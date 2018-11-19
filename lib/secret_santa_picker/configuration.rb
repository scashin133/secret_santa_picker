module SecretSantaPicker
  module ConfigDefault
    DefaultCSVFilePath = "secret_santa.csv"
  end

  class Configuration
    include ConfigDefault

    attr_accessor :csv_file_path, :sender_email, :debug

    def initialize(&block)
      @csv_file_path = DefaultCSVFilePath
      @sender_email = ENV['SENDER_EMAIL']
      @sender_password = ENV['SENDER_PASSWORD']
      @debug = false

      configure(&block) if block
    end

    def configure
      yield self
    end
  end
end
