module SecretSantaPicker
  module ConfigDefault
    DefaultCSVFilePath = "secret_santa.csv"
  end

  class Configuration
    include ConfigDefault

    attr_accessor :csv_file_path

    def initialize(&block)
      @csv_file_path = DefaultCSVFilePath
      configure(&block) if block
    end

    def configure
      yield self
    end
  end
end
