class CreateQuestions < ActiveRecord::Migration[4.2]
  def change
    create_table :questions do |t|
      t.string :category
      t.string :difficulty
      t.string :question
      t.string :correct_answer
      t.string :incorrect_answer
    end
  end
end
