class Question < ActiveRecord::Base
  has_many :games
  has_many :users, through: :games

  def self.new_question
    Question.all.sample
  end

  def make_answers
    answers = []
    answers << self.correct_answer
    answers << self.incorrect_answer1
    answers << self.incorrect_answer2
    answers << self.incorrect_answer3
    answers.shuffle
  end
end

# play games
# answers = question.make_answers
