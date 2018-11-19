module SecretSantaPicker
  class Person
    attr_accessor :name, :email

    def self.generate(csv_array:)
      csv_array.map do |name, email|
        Person.new(name: name, email: email)
      end
    end

    def initialize(name:, email:)
      @name = name
      @email = email
    end
  end
end
