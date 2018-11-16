class Session
  attr_accessor :question ,:answers, :user, :game

  ANSWERED_QUESTIONS = []

  def initialize
    @question = question
    @answers = answers
    @user = user
    @game = game
  end

  def welcome
    print "Welcome to Ruby Trvia \n"
    welcome=
    <<-'EOF'
      ___       __   __         ___    ___  __      __        __         ___  __
|  | |__  |    /  ` /  \  |\/| |__      |  /  \    |__) |  | |__) \ /     |  |__) | \  / |  /\
|/\| |___ |___ \__, \__/  |  | |___     |  \__/    |  \ \__/ |__)  |      |  |  \ |  \/  | /~~\
    EOF

    print welcome

ruby=
<<-'EOF'


                                   _____ ____ _____
                                  /    /      \    \
                                 /____/_________\__ \
                                 \   \          /   /
                                   \  \        /  /
                                     \  \    /  /
                                       \  \/  /
                                          \/
EOF
print ruby

intro =
 <<-'EOF'

 __  __ _             __   __                 ___       _       _ _ _
|  \/  (_)_ __   ___  \ \ / /__  _   _ _ __  |_ _|_ __ | |_ ___| | (_) __ _  ___ _ __   ___ ___
| |\/| | | '_ \ / _ \  \ V / _ \| | | | '__|  | || '_ \| __/ _ \ | | |/ _` |/ _ \ '_ \ / __/ _ \
| |  | | | | | |  __/   | | (_) | |_| | |     | || | | | ||  __/ | | | (_| |  __/ | | | (_|  __/
|_|  |_|_|_| |_|\___|   |_|\___/ \__,_|_|    |___|_| |_|\__\___|_|_|_|\__, |\___|_| |_|\___\___|
                                                                      |___/
    EOF
    print intro


    print "\n"
    print "\n"
  end

  def prompt_user_name
    print "Please enter a username \n"
    print "*********************** \n"
    print "\n"
  end


# def get_user_name(input)
#   # binding.pry
#   if input.length <= 0
#     print "Please enter a valid username you fucking idiot"
#     self.prompt_user_name
#   else
#     self.pick_user(input)
#   end
# end

  # custom find_or_create_by for user
  def pick_user(input)
  # binding.pry
    input_user =  User.find_by(name:"#{input}")
    if input_user.nil?
      self.user = User.create(name:"#{input}")
    else
      self.user = input_user
    end
  end



  def category_prompt
    print "Please enter number to pick a category \n"
    print "************************************** \n"
    print "\n"
    print "1. History \n"
    print "2. Geography \n"
    print "3. Film \n"
    print "4. Music \n"
    print "5. General Knowledge \n"
    print "6. Sports \n"
    print "7. Random Category\n"
    print "\n"
    print "************************************** \n"
    print "\n"
  end

  # Helper method to select question from certain category
  def question_from(category)
    Question.where.not(id: ANSWERED_QUESTIONS.pluck(:id)).where(category: category).sample
  end

  # - Selects a category based on the input of the user.
  # - Adds id of question to ANSWERED_QUESTION pool to prevent that question
  #   from repeating during the current session
  def pick_category(input)
    case input
    when  '1'
      self.question=self.question_from('History')
    when '2'
      self.question=self.question_from('Geography')
    when '3'
      self.question=self.question_from('Entertainment: Film')
    when '4'
      self.question=self.question_from('Entertainment: Music')
    when '5'
      self.question=self.question_from('General Knowledge')
    when '6'
      self.question=self.question_from('Sports')
    when '7'
      self.question=Question.where.not(id: ANSWERED_QUESTIONS.pluck(:id)).sample
    else
      print "Please enter a valid number"
    end

    ANSWERED_QUESTIONS << self.question
  end

  # Combines the correct and incorrect answers into array,
  # the shuffles them for a random order
  def make_answers
    answers = []
    answers << self.question[:correct_answer]
    answers << self.question[:incorrect_answer1]
    answers << self.question[:incorrect_answer2]
    answers << self.question[:incorrect_answer3]
    @answers=answers.shuffle
  end

  # Prints the question, and decodes HTML special characters from data
  def print_question
    ready_answers = self.answers.each_with_index.map do |val,index|
       "#{index+1}. #{HTMLEntities.new.decode val}"
    end
    print  "#{HTMLEntities.new.decode question[:question]} \n"
    print "\n"
    print  "#{ready_answers[0]} \n"
    print  "#{ready_answers[1]} \n"
    print  "#{ready_answers[2]} \n"
    print  "#{ready_answers[3]} \n"
    print "\n"
  end

  def new_game
    self.game = Game.create(user_id: self.user.id, question_id: self.question.id)
  end

  # chooses answer based on user input and the index of the shuffled answers
  def get_text_answer(answer)
    index = answer.to_i - 1
    self.answers[index]
  end

  def get_text_answer(answer)
    index = answer.to_i - 1
    self.answers[index]
  end

  # Checks answer and saves game to db
  def check_answer(answer)
    user_answer = self.get_text_answer(answer)
    if user_answer == self.question[:correct_answer]
      self.game.status = "correct"
      self.game.save
      system "clear"

      yay= <<-'EOF'
╦ ╦╔═╗╦ ╦┬
╚╦╝╠═╣╚╦╝│
 ╩ ╩ ╩ ╩ o
      EOF
      print yay
    else
      self.game.status = "incorrect"
      self.game.save
      system "clear"
      boo=<<-'EOF'
╔╗ ╔═╗╔═╗╔═╗╔═╗╔═╗╔═╗╔═╗╔═╗╔═╗┬
╠╩╗║ ║║ ║║ ║║ ║║ ║║ ║║ ║║ ║║ ║│
╚═╝╚═╝╚═╝╚═╝╚═╝╚═╝╚═╝╚═╝╚═╝╚═╝o
      EOF
      print boo
      print "The correct answer is #{HTMLEntities.new.decode self.question[:correct_answer]}\n"
    end
  end


  def valid_answer?
    answer.to_i.between(1,4)
  end

  def input
    gets.chomp
  end

  # Asks player to play again then either creates another game,
  # ends game, or views player's stats
  def play_again?
    print "\n"
    print "Would you like to play again? Enter: \n"
    print "************************************ \n"
    print "1. Yes \n"
    print "2. No \n"
    print "3. View Stats \n"
    print "\n"
    input =self.input
    case input
    when  '1'
      print "Great!"
      system "clear"
      self.category_prompt                   #
      self.pick_category(gets.chomp)
      system "clear"
      self.new_game
      self.make_answers
      self.print_question
      self.check_answer(gets.chomp)
      self.play_again?
    when '2'
      system "clear"

      bye= <<-'EOF'
______                 _____ _                 _            __                   _             _               _
| ___ \               |_   _| |               | |          / _|                 | |           (_)             | |
| |_/ /_   _  ___       | | | |__   __ _ _ __ | | _____   | |_ ___  _ __   _ __ | | __ _ _   _ _ _ __   __ _  | |
| ___ \ | | |/ _ \      | | | '_ \ / _` | '_ \| |/ / __|  |  _/ _ \| '__| | '_ \| |/ _` | | | | | '_ \ / _` | | |
| |_/ / |_| |  __/  _   | | | | | | (_| | | | |   <\__ \  | || (_) | |    | |_) | | (_| | |_| | | | | | (_| | |_|
\____/ \__, |\___/ (_)  \_/ |_| |_|\__,_|_| |_|_|\_\___/  |_| \___/|_|    | .__/|_|\__,_|\__, |_|_| |_|\__, | (_)
        __/ |                                                             | |             __/ |         __/ |
       |___/                                                              |_|            |___/         |___/


      EOF
      print bye
      # print "Bye. Thanks for playing \n"
    when '3'
      system "clear"
      print "Your Stats \n"
      print "********** \n"
      print "\n"
      print "You have answered #{self.user.correct_percentage}% correctly. \n"
      print "Your best category: #{self.user.best_category} \n"
      print "Your worst category is: #{self.user.worst_category} \n"
      print "\n"
      self.play_again?
    end
  end


end
