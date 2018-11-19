module SecretSantaPicker
  class Pair
    attr_accessor :from, :to

    def self.generate(persons:)
      from_persons = persons.dup.shuffle
      to_persons = persons.dup.shuffle

      pairs = []

      from_persons.each do |from_person|
        not_found_partner = true
        while not_found_partner
          to_person = to_persons.pop

          if from_person == to_person
            to_persons.unshift(to_person)
          else
            not_found_partner = false
            pairs << Pair.new(from: from_person, to: to_person)
          end
        end
      end

      pairs
    end

    def initialize(from:, to:)
      @from = from
      @to = to
    end
  end
end
