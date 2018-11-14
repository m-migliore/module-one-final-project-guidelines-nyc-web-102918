class AddDefaultGameStatus < ActiveRecord::Migration[4.2]
  def change
    remove_column :games, :status
    add_column :games, :status, :string, default:"pending"
    end
  end
