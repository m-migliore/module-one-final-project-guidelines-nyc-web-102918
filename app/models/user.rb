class User < ActiveRecord::Base
  has_many :games
  has_many :questions, through: :games

  def correct_question_amount
    Game.where({status: "correct", user_id: self.id }).length
  end

  def total_question_amount
    Game.where(user_id: self.id).length
  end
end
