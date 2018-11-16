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
    print"'Mine Your Intelligence'\n"
    print "\n"
    print "\n"
    print "Please enter a username \n"
    print "*********************** \n"
    print "\n"
  end

  # custom find_or_create_by for user
  def pick_user(input)
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
    print "7. Random \n"
    print "\n"
    print "************************************** \n"
    print "\n"
  end

  # - Selects a category based on the input of the user.
  # - Adds id of question to ANSWERED_QUESTION pool to prevent that question
  #   from repeating during the current session
  def pick_category(input)
    case input
    when  '1'
      self.question=Question.where.not(id: ANSWERED_QUESTIONS.pluck(:id)).where(category:'History').sample
    when '2'
      self.question=Question.where.not(id: ANSWERED_QUESTIONS.pluck(:id)).where(category:'Geography').sample
    when '3'
      self.question=Question.where.not(id: ANSWERED_QUESTIONS.pluck(:id)).where(category:'Entertainment: Film').sample
    when '4'
      self.question=Question.where.not(id: ANSWERED_QUESTIONS.pluck(:id)).where(category:'Entertainment: Music').sample
    when '5'
      self.question=Question.where.not(id: ANSWERED_QUESTIONS.pluck(:id)).where(category:'General Knowledge').sample
    when '6'
      self.question=Question.where.not(id: ANSWERED_QUESTIONS.pluck(:id)).where(category:'Sports').sample
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

  # def check_answer(answer)
  #   # answer=gets.chomp
  #   if self.valid_answer?
  #     if answer==self.question[:correct_answer]
  #     end
  #   else
  #     "Please input a number between 1 and 4"
  #   end
  # end

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
      print "YAY \n"
    else
      self.game.status = "incorrect"
      self.game.save
      system "clear"
      print "BOOO \n"
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
      print "Bye. Thanks for playing \n"
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

  # def new_round(input)
  #   # self.category_prompt                   #
  #   # self.pick_category(gets.chomp)
  #   # system "clear"
  #   # self.new_game
  #   # self.make_answers
  #   # self.print_question
  #   # self.check_answer(gets.chomp)
  #   # self.play_again?
  # end


# def get_all_questions_answered_incorrectedly
#   Question.includes(:games).where(games: {status: "incorrect"})
# end


# to prevent duplicate questions from appearing, when new question is selected, its id is added to an array
# then a new pick_category is run based on to selct question where the id is not in the old array

# if no new questions, thne print 'you answered' everything'

end
