class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.belongs_to :game
      t.text :correct_answer
      t.text :user_guess
      t.boolean :correct
    end
  end
end
