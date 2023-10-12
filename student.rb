require_relative 'Person'
require_relative 'classroom'

class Student < Person
  attr_reader :classroom

  def initialize(age:, classroom:, name: 'Unknown', parent_permission: true)
    super(name: name, age: age, parent_permission: parent_permission)
    assign_to_classroom(classroom) if classroom
  end

  def assign_to_classroom(classroom)
    return if classroom == @classroom

    if @classroom
      @classroom.students.delete(self)
    end

    @classroom = classroom
    classroom.add_student(self)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
