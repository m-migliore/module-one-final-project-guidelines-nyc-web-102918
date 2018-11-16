require_relative '../config/environment'

session = Session.new
system "clear"
session.welcome
session.prompt_user_name
# session.get_user_name(gets.chomp)
session.pick_user(gets.chomp)
system "clear"
session.category_prompt                   #
session.pick_category(gets.chomp)
system "clear"
session.new_game
session.make_answers
session.print_question
session.check_answer(gets.chomp)         #
session.play_again?
