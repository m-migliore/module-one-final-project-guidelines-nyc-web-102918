class CreateGames < ActiveRecord::Migration[4.2]
  def change
    create_table :games do |t|
      t.string :status
      t.integer :user_id
      t.integer :question_id
    end
  end
end
