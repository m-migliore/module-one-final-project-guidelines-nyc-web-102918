class Question < ActiveRecord::Base
  has_many :games
  has_many :users, through: :games

  def self.new_question
    Question.all.sample
  end

end
