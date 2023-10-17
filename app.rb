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
  end

  def list_books
    puts 'List of All Books:'
    @books.each { |book| puts " Title: #{book.title}, Author: #{book.author}" }
  end

  def list_people
    puts 'List of People:'
    @people.each do |person|
      puts person.description
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
    create_person_with_type(Teacher)
  end

  def create_student
    create_person_with_type(Student)
  end

  def create_person_with_type(person_type)
    puts 'Enter age:'
    age = gets.chomp.to_i

    puts 'Enter name:'
    name = gets.chomp

    person = person_type.new(age, name)
    @people << person
    puts 'Person created successfully!'
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
    person = select_person('Select a person by number:')
    return unless person

    book = select_book('Select a book by number:')
    return unless book

    date = get_valid_date
    return unless date

    rental = Rental.new(date, book, person)
    @rentals << rental
    puts 'Rental created successfully'
  end

  def select_person(prompt)
    puts prompt
    list_people_with_numbers
    person_number = gets.chomp.to_i

    selected_person = @people[person_number - 1]

    return selected_person if selected_person

    puts 'Invalid person selection'
    nil
  end

  def select_book(prompt)
    puts prompt
    list_books_with_numbers
    book_number = gets.chomp.to_i

    selected_book = @books[book_number - 1]

    return selected_book if selected_book

    puts 'Invalid book selection'
    nil
  end

  def get_valid_date
    puts 'Date (YYYY-MM-DD):'
    date_str = gets.chomp

    begin
      Date.parse(date_str)
    rescue ArgumentError
      puts 'Invalid date format. Please use YYYY-MM-DD.'
      nil
    end
  end

  def list_books_with_numbers
    @books.each_with_index do |book, index|
      puts "#{index + 1}. #{book.title} by #{book.author}"
    end
  end

  def list_people_with_numbers
    @people.each_with_index do |person, index|
      puts "#{index + 1}. #{person.description}"
    end
  end
end
