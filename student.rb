require_relative 'person'

class Student
  attr_accessor :age, :name, :parent_permission, :rentals

  def initialize(age, name, parent_permission)
    @age = age
    @name = name
    @parent_permission = parent_permission
    @rentals = []
  end
end
