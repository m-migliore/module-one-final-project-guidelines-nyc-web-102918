class User < ActiveRecord::Base
  has_many :games
  has_many :questions, through: :games

  def correct_questions
    self.winning_games.map do |game|
      game.question
    end
  end

  def winning_games
    Game.where({status: "correct", user_id: self.id })
  end

  def history_correct
    self.correct_questions.select do |question|
      question.category == "History"
    end
  end

  def geography_correct
    self.correct_questions.select do |question|
      question.category == "Geography"
    end
  end

  def film_correct
    self.correct_questions.select do |question|
      question.category == "Entertainment: Film"
    end
  end

  def music_correct
    self.correct_questions.select do |question|
      question.category == "Entertainment: Music"
    end
  end

  def general_knowledge_correct
    self.correct_questions.select do |question|
      question.category == "General Knowledge"
    end
  end

  def sports_correct
    self.correct_questions.select do |question|
      question.category == "Sports"
    end
  end

  def correct_question_amount
    self.correct_questions.length
  end

  def wins_by_category
    total_wins = {
      "History" => history_correct.length,
      "Geography" => geography_correct.length,
      "Film" => film_correct.length,
      "Music" => music_correct.length,
      "General Knowledge" => general_knowledge_correct.length,
      "Sports" => sports_correct.length
    }
    total_wins.sort {|a,b| b[1]<=>a[1]}.to_h
  end

  def best_category
    self.wins_by_category.keys.first
  end

  def worst_category
    self.wins_by_category.keys.last
  end

  # def best_category
  #   total_wins={
  #     "History" => history_correct.length,
  #     "Geography" => geography_correct.length,
  #     "Film" => film_correct.length,
  #     "Music" => music_correct.length,
  #     "General Knowledge" => general_knowledge_correct.length,
  #     "Sports" => sports_correct.length
  #     }
  #   sorted_total_wins = total_wins.sort {|a,b| b[1]<=>a[1]}.to_h
  #   sorted_total_wins.keys.first
  # end

  def total_question_amount
    Game.where(user_id: self.id).length
  end

  def correct_percentage
    (self.correct_question_amount / self.total_question_amount.to_f).round(2) * 100
  end
end
