class Question < ActiveRecord::Base
  has_many :games
  has_many :users, through: :games

  def self.new_question
    Question.all.sample
  end

end

#   def make_answers
#     answers = []
#     answers << self.correct_answer
#     answers << self.incorrect_answer1
#     answers << self.incorrect_answer2
#     answers << self.incorrect_answer3
#     answers.shuffle
#   end
# end

# play games
# answers = question.make_answers

# def self.most_popular # self is a listing in this case
#     most_trips=0
#     most_popular_listing=nil
#     self.all.each do |listing|
#       if listing.trips.length> most_trips
#         most_trips =listing.trips.length
#         most_popular_listing=listing
#       end
#     end
#     most_popular_listing
#   end

# session.user.games.map do |game|
#  game.question
# end
