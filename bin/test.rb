require_relative '../config/environment'

session = Session.new
puts "Welcome to trivia! Enter username"
# session.pick_user(gets.chomp)
puts "Please enter number to pick a category \n"
puts "1. History \n"
puts "2. Geography \n"
puts "3. Film \n"
puts "4. Music \n"
puts "5. General Knowledge \n"
puts "6. Sports \n"
puts "7. Random \n"




session.pick_category(gets.chomp)
#session.pick_category('7')
session.make_answers
session.print_question
session.check_answer(gets.chomp)

# binding.pry

meh
