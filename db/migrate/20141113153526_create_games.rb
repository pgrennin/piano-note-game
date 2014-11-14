class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.belongs_to :user
      t.integer :game_length
      t.integer :score

      t.timestamps
    end
  end
end
