require 'byebug'

RSpec.describe SecretSantaPicker::Pair do
    describe '.generate' do
        subject(:persons) { [SecretSantaPicker::Person.new(name: "mike", email: "mike@gmail.com"), SecretSantaPicker::Person.new(name: "sean", email: "sean@gmail.com"), SecretSantaPicker::Person.new(name: "scott", email: "scott@gmail.com")] }
        subject(:pairs) { SecretSantaPicker::Pair.generate(persons: persons) }

        it 'assigns the 3 pairs of people' do
            expect(pairs.length).to equal(persons.length)
        end

        it 'does not assign any single person to be the same' do
            pairs.each do |pair|
                expect(pair.from).not_to equal(pair.to)
            end
        end

        it 'only assigns a person to be a gifter once' do
            unique_people = pairs.map { |p| p.to }.uniq.compact

            expect(unique_people.length).to equal(persons.length)
        end

        it 'only assigns a person to be a recipient once' do
            unique_people = pairs.map { |p| p.from }.uniq.compact

            expect(unique_people.length).to equal(persons.length)
        end
    end
end
