require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'teacher'
require_relative 'student'
require_relative 'classroom'
require_relative 'specialization'
require 'date'
require 'json'
require_relative 'writeFile'
class App
  def initialize
    @people = []
    @books = []
    @rentals = []
    @classrooms = []
    @specializations = []
    load_data
  end

  def load_data
    if File.exist?('books.json')
      books_data = JSON.load(File.read('books.json'))
      @books = books_data.map { |book_data| Book.new(book_data['title'], book_data['author']) }
    end

    if File.exist?('people.json')
      people_data = JSON.load(File.read('people.json'))
      @people = people_data.map do |person_data|
        if person_data['type'] == 'teacher'
          Teacher.new(
            find_or_create_specialization(person_data['specialization']),
            person_data['age'],
            person_data['name']
          )
        else
          Student.new(
            person_data['age'],
            person_data['name'],
            person_data['parent_permission']
          )
        end
      end
    end

    return unless File.exist?('rentals.json')

    @rentals = JSON.load(File.read('rentals.json'))
  end

  def save_data
    books_data = @books.map { |book| { title: book.title, author: book.author } }
    WriteFile.new('books.json').write(books_data)

    people_data = @people.map do |person|
      if person.is_a?(Teacher)
        {
          type: 'teacher',
          age: person.age,
          name: person.name,
          specialization: person.specialization.label
        }
      else
        {
          type: 'student',
          age: person.age,
          name: person.name,
          parent_permission: person.parent_permission
        }
      end
    end
    WriteFile.new('people.json').write(people_data)

    File.write('rentals.json', JSON.dump(@rentals))
  end

  def list_books
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}, Available: #{book.available ? 'Yes' : 'No'}"
    end
  end

  def list_people
    @people.each do |person|
      if person.is_a?(Teacher)
        puts "Teacher: Name: #{person.name}, Age: #{person.age}, Specialization: #{person.specialization}"
      elsif person.is_a?(Student)
        puts "Student: Name: #{person.name}, Age: #{person.age}, Parent Permission: #{person.parent_permission ? 'Yes' : 'No'}"
      else
        puts "Unknown Type: #{person.class}"
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

    teacher = Teacher.new(specialization, age, name)
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

    student = Student.new(age, name, parent_permission)
    @people << student
    save_data
    puts 'Person created successfully!'
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
    save_data
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
      if person.is_a?(Student)
        puts "#{index + 1}. #{person.name} (ID: #{person.id if person.respond_to?(:id)})"
      else
        puts "#{index + 1}. #{person.name}"
      end
    end
  end

  def list_rentals_for_person
    puts 'Select a person from the following list by number (not id):'
    list_people_with_numbers
    person_number = gets.chomp.to_i

    if person_number >= 1 && person_number <= @people.length
      selected_person = @people[person_number - 1]

      puts 'Rentals:'
      selected_person.rentals.each do |rental|
        puts " Date: #{rental.date.strftime('%y-%m-%d')}, Book: #{rental.book.title} by #{rental.book.author} "
      end
    else
      puts 'Invalid person selection.'
    end
  end
end
