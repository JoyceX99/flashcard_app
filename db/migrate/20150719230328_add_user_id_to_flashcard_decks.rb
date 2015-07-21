class AddUserIdToFlashcardDecks < ActiveRecord::Migration
  def change
    add_column :flashcard_decks, :user_id, :integer
  end
end
