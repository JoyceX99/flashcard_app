class FlashcardDeck < ActiveRecord::Base
  belongs_to :user
  has_many :flashcards, dependent: :destroy

  accepts_nested_attributes_for :flashcards, reject_if: Proc.new { |card| card[:front].blank? || card[:back].blank? }, allow_destroy: true

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 350 }, allow_blank: true
end
