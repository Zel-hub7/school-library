class App
    def initialize
      @books = [] 
      @people = []    
      @rentals = []   
    end
  
    def list_books
      puts 'List of available books:'
      @books.each do |book|
        puts "Title: #{book[:title]}, Author: #{book[:author]}"
      end
    end
  
    def list_people
      puts 'List of library members:'
      @people.each do |person|
        puts "Name: #{person[:name]}, Type: #{person[:type]}"
      end
    end
  
    def create_person
      puts 'Enter the name of the new library member:'
      name = gets.chomp
      puts 'Enter the type of the new member (teacher or student):'
      type = gets.chomp
      @people << { name: name, type: type }
      puts "#{name} has been added as a #{type}."
    end
  
    def create_book
      puts 'Enter the title of the new book:'
      title = gets.chomp
      puts 'Enter the author of the new book:'
      author = gets.chomp
      @books << { title: title, author: author }
      puts "The book '#{title}' by #{author} has been added to the library."
    end
  
    def create_rental
      # Sample logic to create a rental
      puts 'Enter the name of the library member renting the book:'
      person_name = gets.chomp
      puts 'Enter the title of the book being rented:'
      book_title = gets.chomp
      person = @people.find { |p| p[:name] == person_name }
      book = @books.find { |b| b[:title] == book_title }
      
      if person && book
        @rentals << { person: person, book: book }
        puts "#{person_name} has rented '#{book_title}'."
      else
        puts 'Invalid person or book. Rental could not be created.'
      end
    end
  
    def list_rentals_for_person
      # Sample logic to list rentals for a person
      puts 'Enter the name of the library member to view their rentals:'
      person_name = gets.chomp
      person = @people.find { |p| p[:name] == person_name }
      
      if person
        rentals = @rentals.select { |r| r[:person] == person }
        puts "#{person_name}'s rentals:"
        rentals.each do |rental|
          book = rental[:book]
          puts "Book: #{book[:title]} by #{book[:author]}"
        end
      else
        puts "Person not found. No rentals to display."
      end
    end
  end
  