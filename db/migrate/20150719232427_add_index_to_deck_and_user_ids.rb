class AddIndexToDeckAndUserIds < ActiveRecord::Migration
  def change
    add_index :flashcards, :flashcard_deck_id
    add_index :flashcard_decks, :user_id
  end
end
