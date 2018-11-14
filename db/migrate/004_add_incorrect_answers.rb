class AddIncorrectAnswers < ActiveRecord::Migration[4.2]
  def change
    remove_column :questions, :incorrect_answer
    add_column :questions,:incorrect_answer1,:string
    add_column :questions,:incorrect_answer2,:string
    add_column :questions,:incorrect_answer3,:string
    end
  end
