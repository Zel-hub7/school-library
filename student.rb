require_relative 'person'

class Student < Person
  attr_accessor :name, :classroom

  def initialize(age, name, parent_permission)
    super(age, name, parent_permission: parent_permission)
  end
end
