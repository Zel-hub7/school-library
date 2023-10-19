require 'rspec'
require_relative '../person'

describe Person do
  let(:person) { Person.new(25, 'John', parent_permission: false) }
  let(:rental) { double('Rental') }

  context 'Initialization' do
    it 'initializes with age, name, and parent permission' do
      expect(person.age).to eq(25)
      expect(person.name).to eq('John')
      expect(person.parent_permission).to be_falsey
      expect(person.rentals).to eq([])
    end

    it 'initializes with a unique ID' do
      expect(person.id).to be_a(Integer)
    end

    it 'initializes with default name "Unknown" if name is not provided' do
      person_without_name = Person.new(30)
      expect(person_without_name.name).to eq('unknown')
    end
  end

  context 'Permission to Use Services' do
    it 'can use services with parent permission' do
      person_with_permission = Person.new(15, 'Bob', parent_permission: true)
      expect(person_with_permission.can_use_services?).to be_truthy
    end

    it 'cannot use services without parent permission if under age' do
      underage_person = Person.new(16, 'Alice', parent_permission: false)
      expect(underage_person.can_use_services?).to be_falsey
    end

    it 'can use services without parent permission if over age' do
      adult_person = Person.new(18, 'Eve', parent_permission: false)
      expect(adult_person.can_use_services?).to be_truthy
    end
  end

  it 'correctly returns the name' do
    expect(person.correct_name).to eq('John')
  end

  it 'does not correct the name' do
    person_with_long_name = Person.new(30, 'alongnameiscorrected')
    expect(person_with_long_name.correct_name).to eq('alongnameiscorrected')
  end

  context 'Rental' do
    it 'can add a rental and return it' do
      expect(person.add_rental(rental)).to eq([rental])
      expect(person.rentals).to include(rental)
    end
  end
end