class Flashcard < ActiveRecord::Base
  belongs_to :flashcard_deck

  validates :front, presence: true, length: {maximum: 400}
  validates :back, presence: true, length: {maximum: 400}
end
