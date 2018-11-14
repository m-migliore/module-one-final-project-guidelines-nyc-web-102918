class Session
  attr_accessor :question

  @@all = []

  def initialize
    @question = Question.all.sample
    @@all << self
  end

  def print_question
    answers = self.question.make_answers
    ready_answers = answers.each_with_index.map do |val,index|
       "#{index+1}. #{HTMLEntities.new.decode val}"
    end
    print  "#{HTMLEntities.new.decode question[:question]} \n"
    print  "#{ready_answers[0]} \n"
    print  "#{ready_answers[1]} \n"
    print  "#{ready_answers[2]} \n"
    print  "#{ready_answers[3]} \n"
  end

end
