require_relative 'application'

class MySchoolApp
  def initialize
    @app = App.new
    @choices = {
      1 => :list_books,
      2 => :list_people,
      3 => :create_person,
      4 => :create_book,
      5 => :create_rental,
      6 => :list_rentals_for_person,
      7 => :quit
    }
  end

  def run
    display_custom_welcome

    loop do
      display_custom_menu
      user_choice = gets.chomp.to_i

      break if process_user_choice(user_choice) == :quit
    end

    puts 'Thanks for using My School Library App. Goodbye!'
  end

  def display_custom_welcome
    puts 'Welcome to My School Library App!'
    puts 'Discover and manage books, people, and rentals.'
    puts
  end

  def display_custom_menu
    puts 'Choose an option by entering a number:'
    puts '1. Show all available books'
    puts '2. List all library members'
    puts '3. Add a new library member (teacher or student)'
    puts '4. Add a new book to the library'
    puts '5. Create a rental'
    puts '6. View rentals for a library member'
    puts '7. Quit'
  end

  def process_user_choice(choice)
    action = @choices[choice]

    if action
      send(action)
    else
      puts 'Invalid choice. Please select a valid option.'
    end
  end

  private

  def list_books
    @app.list_books
  end

  def list_people
    @app.list_people
  end

  def create_person
    @app.create_person
  end

  def create_book
    @app.create_book
  end

  def create_rental
    @app.create_rental
  end

  def list_rentals_for_person
    @app.list_rentals_for_person
  end

  def quit
    :quit
  end
end
