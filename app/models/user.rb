class User < ActiveRecord::Base
  has_many :games
  has_many :questions, through: :games

  def correct_questions
    Game.where({status: "correct", user_id: self.id })
  end

  def correct_question_amount
    self.correct_questions.length
  end

  def total_question_amount
    Game.where(user_id: self.id).length
  end

  def correct_percentage
    (self.correct_question_amount / self.total_question_amount.to_f).round(2) * 100
  end
end
