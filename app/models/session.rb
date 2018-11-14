class Session
  attr_accessor :question,:answers, :user

  @@all = []

  def initialize
    # @question = Question.all.sample
    @question=question
    @answers=answers
    @user=user
    @@all << self
  end

  def pick_user(input)
    self.user=User.create(name:"#{input}")
  end


  def pick_category(input)
    # input=gets.chomp
    case input
    when  '1'
      self.question=Question.where(category:'History').sample
    when '2'
      self.question=Question.where(category:'Geography').sample
    when '3'
      self.question=Question.where(category:'Entertainment: Film').sample
    when '4'
      self.question=Question.where(category:'Entertainment: Music').sample
    when '5'
      self.question=Question.where(category:'General Knowledge').sample
    when '6'
      self.question=Question.where(category:'Sports').sample
    when '7'
      self.question=Question.all.sample
    else
      puts "Please enter a valid number"
    end
  end

  def make_answers
    answers = []
    answers << self.question[:correct_answer]
    answers << self.question[:incorrect_answer1]
    answers << self.question[:incorrect_answer2]
    answers << self.question[:incorrect_answer3]
    @answers=answers.shuffle
  end


  def print_question
    # answers = self.question.make_answers
    ready_answers = self.answers.each_with_index.map do |val,index|
       "#{index+1}. #{HTMLEntities.new.decode val}"
    end
    print  "#{HTMLEntities.new.decode question[:question]} \n"
    print "\n"
    print  "#{ready_answers[0]} \n"
    print  "#{ready_answers[1]} \n"
    print  "#{ready_answers[2]} \n"
    print  "#{ready_answers[3]} \n"
  end

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

  def check_answer(answer)
    user_answer = self.get_text_answer(answer)
    if user_answer == self.question[:correct_answer]
      print "YAY \n"
    else
      print "BOOO \n"
      print "The correct answer is #{HTMLEntities.new.decode self.question[:correct_answer]}\n"
    end
  end


  def valid_answer?
    answer.to_i.between(1,4)
  end

  def get_text_answer(answer)
    index = answer.to_i - 1
    self.answers[index]
  end




end
