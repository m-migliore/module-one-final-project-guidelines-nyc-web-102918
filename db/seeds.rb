require_relative './question_data'
Game.delete_all
Question.delete_all



  HISTORY_QUESTIONS.each do |history_hash|
    Question.create(category: history_hash[:category], difficulty: history_hash[:difficulty], question: history_hash[:question], correct_answer: history_hash[:correct_answer], incorrect_answer1: history_hash[:incorrect_answers][0],incorrect_answer2: history_hash[:incorrect_answers][1],incorrect_answer3: history_hash[:incorrect_answers][2] )
  end


  GEOGRAPHY_QUESTIONS.each do |geography_hash|
    Question.create(category: geography_hash[:category], difficulty: geography_hash[:difficulty], question: geography_hash[:question], correct_answer: geography_hash[:correct_answer], incorrect_answer1: geography_hash[:incorrect_answers][0],incorrect_answer2: geography_hash[:incorrect_answers][1],incorrect_answer3: geography_hash[:incorrect_answers][2] )
  end


  SPORTS_QUESTIONS.each do |sports_hash|
    Question.create(category: sports_hash[:category], difficulty: sports_hash[:difficulty], question: sports_hash[:question], correct_answer: sports_hash[:correct_answer], incorrect_answer1: sports_hash[:incorrect_answers][0],incorrect_answer2: sports_hash[:incorrect_answers][1],incorrect_answer3: sports_hash[:incorrect_answers][2] )
  end


  GENERAL_KNOWLEDGE_QUESTIONS.each do |general_knowledge_hash|
    Question.create(category: general_knowledge_hash[:category], difficulty: general_knowledge_hash[:difficulty], question: general_knowledge_hash[:question], correct_answer: general_knowledge_hash[:correct_answer], incorrect_answer1: general_knowledge_hash[:incorrect_answers][0],incorrect_answer2: general_knowledge_hash[:incorrect_answers][1],incorrect_answer3: general_knowledge_hash[:incorrect_answers][2] )
  end


  FILM_QUESTIONS.each do |film_questions_hash|
    Question.create(category: film_questions_hash[:category], difficulty: film_questions_hash[:difficulty], question: film_questions_hash[:question], correct_answer: film_questions_hash[:correct_answer], incorrect_answer1: film_questions_hash[:incorrect_answers][0],incorrect_answer2: film_questions_hash[:incorrect_answers][1],incorrect_answer3: film_questions_hash[:incorrect_answers][2] )
  end


  MUSIC_QUESTIONS.each do |music_questions_hash|
    Question.create(category: music_questions_hash[:category], difficulty: music_questions_hash[:difficulty], question: music_questions_hash[:question], correct_answer: music_questions_hash[:correct_answer], incorrect_answer1: music_questions_hash[:incorrect_answers][0],incorrect_answer2: music_questions_hash[:incorrect_answers][1],incorrect_answer3: music_questions_hash[:incorrect_answers][2] )
  end
