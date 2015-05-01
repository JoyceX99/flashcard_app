class AddFlashcardDeckIdToFlashcards < ActiveRecord::Migration
  def change
    add_column :flashcards, :flashcard_deck_id, :integer
  end
end
