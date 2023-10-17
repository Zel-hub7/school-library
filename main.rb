require_relative 'app'
require_relative 'interface'

my_school_app = App.new
user_interface = UserInterface.new(my_school_app)

user_interface.start
