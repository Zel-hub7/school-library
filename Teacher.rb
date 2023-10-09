require_relative 'Person'

class Teacher < Person
  attr_reader :specialization

  def initialize(name: 'Unknown', age: nil, parent_permission: true, specialization: 'General')
    super(name: name, age: age, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
