require_relative '../config/environment'

session = Session.new
puts "welcome to trivia, pick a category"
session.pick_category(gets.chomp)
#session.pick_category('7')
session.make_answers
session.print_question
session.check_answer(gets.chomp)

binding.pry

meh
