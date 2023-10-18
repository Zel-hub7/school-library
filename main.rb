require_relative 'app'

def main
  my_school_app = App.new
  welcome_message_shown = false

  loop do
    unless welcome_message_shown
      display_custom_welcome
      welcome_message_shown = true
    end

    display_custom_menu
    user_choice = gets.chomp.to_i

    process_user_choice(user_choice, my_school_app)

    my_school_app.save_data

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
  puts '1. Show all available books'
  puts '2. List all library members'
  puts '3. Add a new library member (teacher or student)'
  puts '4. Add a new book to the library'
  puts '5. Create a rental'
  puts '6. View rentals for a library member'
  puts '7. Quit'
end

def process_user_choice(choice, app_instance)
  case choice
  when 1
    app_instance.list_books
  when 2
    app_instance.list_people
  when 3
    app_instance.create_person
  when 4
    app_instance.create_book
  when 5
    app_instance.create_rental
  when 6
    app_instance.list_rentals_for_person
  when 7
    puts 'Thanks for using My School Library App. Goodbye!'
  else
    puts 'Invalid choice. Please select a valid option.'
  end
end


main
