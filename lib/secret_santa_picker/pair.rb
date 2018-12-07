module SecretSantaPicker
  class Pair
    attr_accessor :from, :to

    def self.generate(persons:)
      all_people = persons.dup.shuffle

      all_people.map.with_index do |person, index|
        to_person = index == (all_people.count - 1) ? all_people[0] : all_people[index + 1]

        Pair.new(from: person, to: to_person)
      end
    end

    def initialize(from:, to:)
      @from = from
      @to = to
    end
  end
end
