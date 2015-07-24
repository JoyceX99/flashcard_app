class HomeController < ApplicationController
  def home
  end

  def browse
    @decks = FlashcardDeck.all.order(created_at: :desc)
  end

end
