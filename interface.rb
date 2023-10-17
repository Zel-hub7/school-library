class UserInterface
    MENU_OPTIONS = {
      1 => 'Show all available books',
      2 => 'List all library members',
      3 => 'Add a new library member (teacher or student)',
      4 => 'Add a new book to the library',
      5 => 'Create a rental',
      6 => 'View rentals for a library member',
      7 => 'Quit'
    }.freeze
  
    def initialize(app)
      @app = app
      @welcome_message_shown = false
    end
  
    def start
      loop do
        unless @welcome_message_shown
          display_custom_welcome
          @welcome_message_shown = true
        end
  
        display_custom_menu
        user_choice = gets.chomp.to_i
  
        process_user_choice(user_choice)
  
        break if user_choice == 7
      end
    end
  
    def display_custom_welcome
      puts 'Welcome to My School Library App!'
      puts 'Discover and manage books, people, and rentals.'
      puts
    end
  
    def display_custom_menu
      puts 'Choose an option by entering a number:'
      MENU_OPTIONS.each { |key, value| puts "#{key}. #{value}" }
    end
  
    def process_user_choice(choice)
      case choice
      when 1
        @app.list_books
      when 2
        @app.list_people
      when 3
        @app.create_person
      when 4
        @app.create_book
      when 5
        @app.create_rental
      when 6
        @app.list_rentals_for_person
      when 7
        puts 'Thanks for using My School Library App. Goodbye!'
      else
        puts 'Invalid choice. Please select a valid option.'
      end
    end
end
  