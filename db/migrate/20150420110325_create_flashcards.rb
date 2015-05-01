class CreateFlashcards < ActiveRecord::Migration
  def change
    create_table :flashcards do |t|
      t.integer :flashcard_deck_id
      t.string :front
      t.string :back

      t.timestamps null: false
    end
  end
end
