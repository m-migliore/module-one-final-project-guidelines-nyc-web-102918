require_relative '../config/environment'

session = Session.new
session.welcome
session.pick_user(gets.chomp)
session.category_prompt
session.pick_category(gets.chomp)
session.new_game
#make Game.new

#session.pick_category('7')
session.make_answers
session.print_question
session.check_answer(gets.chomp)

# binding.pry

# meh
