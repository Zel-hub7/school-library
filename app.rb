require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'teacher'
require_relative 'student'
require_relative 'classroom'
require_relative 'specialization'
require 'date'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
    @classrooms = []
    @specializations = []
  end

  def list_books
    puts 'List of All Books:'
    @books.each { |book| puts " Title: #{book.title}, Author: #{book.author}" }
  end

  def list_people
    puts 'List of People:'
    @people.each do |person|
        case person
        when Teacher
          puts "[Teacher] Name:#{person.name} ID: #{person.id}  Age:#{person.age}"
        when Student
          puts "[Student] Name:#{person.name} ID:#{person.id} Age:#{person.age}"
        else
          puts "Unknown Type: Name: #{person.name} ID:#{person.id} Age:#{person.age}"
        end
        
    end
  end

  def create_person
    puts 'Do you want to create a teacher (1) or a student (2)? [Input the number]'
    type_option = gets.chomp.to_i
    case type_option
    when 1 then create_teacher
    when 2 then create_student
    else
      puts 'Invalid option'
    end
    
  end

  def create_teacher
    puts 'Enter age:'
    age = gets.chomp.to_i

    puts 'Enter name for the teacher:'
    name = gets.chomp

    puts 'Specialization:'
    specialization_label = gets.chomp

    specialization = find_or_create_specialization(specialization_label)

    teacher = Teacher.new(name: name, age: age, specialization: specialization)
    @people << teacher
    puts 'Person created successfully!'
  end

  def find_or_create_specialization(label)
    specialization = @specializations.find { |s| s.label == label }
    specialization ||= Specialization.new(label)
    @specializations << specialization    
    specialization
  end

  def create_student
    puts 'Enter age:'
    age = gets.chomp.to_i

    puts 'Enter name for the student:'
    name = gets.chomp

    puts 'Has parent permission?(Y/N):'
    parent_permission = gets.chomp.upcase == 'Y'

    student = Student.new(name: name, age: age, parent_permission: parent_permission)
    @people << student
    puts 'Person created succesfully!'
  end

  def find_or_create_classroom(label)
    classroom = @classrooms.find { |c| c.label == label }
    unless classroom
      classroom = Classroom.new(label)
      @classrooms << classroom
    end

    classroom
  end

  def create_book
    puts 'Title:'
    title = gets.chomp
    puts 'Author:'
    author = gets.chomp
    book = Book.new(title, author)
    @books << book
    puts 'Book created successfully.'
  end

  def create_rental
    puts 'Select a person from the following list by number (not id):'
    list_people_with_numbers
    person_number = gets.chomp.to_i

    selected_person = @people[person_number - 1]

    if selected_person
      puts 'Select a book from the following list by number'
      list_books_with_numbers
      book_number = gets.chomp.to_i

      selected_book = @books[book_number - 1]

      if selected_book
        puts 'Date (YYYY-MM-DD):'
        gets.chomp

        begin
          date = Time.now
          rental = Rental.new(date, selected_book, selected_person)
          @rentals << rental
          puts 'Rental created successfully'
        rescue ArgumentError
          puts 'Invalid date format. Please use YYYY-MM-DD.'
        end
      else
        puts 'Invalid book selection'
      end
    else
      puts 'Invalid person selection'
    end
  end

  def list_books_with_numbers
    @books.each_with_index do |book, index|
      puts "#{index + 1}. #{book.title} by #{book.author}"
    end
  end

  def list_people_with_numbers
    @people.each_with_index do |person, index|
      puts "#{index + 1}. #{person.name} (ID: #{person.id})"
    end
  end

  def list_rentals_for_person
    puts 'ID of person:'
    person_id = gets.chomp.to_i

    person = @people.find { |p| p.id == person_id }

    if person
      puts 'Rentals:'
      person.rentals.each do |rental|
        puts " Date: #{rental.date.strftime('%y-%m-%d')}, Book: #{rental.book.title} by #{rental.book.author} "
      end
    else
      puts 'Person not found.'
    end
  end
end