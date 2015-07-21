class FlashcardDecksController < ApplicationController

  # GET list of flashcards
  def index
    #@decks = FlashcardDeck.order(id: :desc).all
    @decks = current_user.flashcard_decks.order(id: :desc)
    render 'shared/_decks_home'
  end

  # GET form for creating new flashcard deck
  def new
    @deck = FlashcardDeck.new
  end

  # POST new flashcard deck
  def create
    @deck = current_user.flashcard_decks.new(deck_params)
    if @deck.save
      redirect_to user_flashcard_decks_path
    else
      render :new
    end
  end

  # GET selected flashcard deck -- LIST VIEW
  def show
    @deck = FlashcardDeck.find(params[:id])
    if params[:flashcard_mode]
      @flashcards = @deck.flashcards.sort_by { rand }
      @flashcard_mode = true
    else
      @flashcards = @deck.flashcards
    end

    if @flashcards.count == 0
      3.times {@deck.flashcards.build}
    end
  end

  # GET form for editing flashcard deck
  def edit
    @deck = FlashcardDeck.find(params[:id])
  end

  # PUT update
  def update
    @deck = FlashcardDeck.find(params[:id])
    if @deck.update_attributes(deck_params)
      redirect_to @deck
    else
      redirect_to root_path
    end
  end

  # DELETE flashcard deck
  def destroy
    @deck = FlashcardDeck.find(params[:id])
    @deck.destroy
    redirect_to root_path
  end

  private
    def deck_params
      params.require(:flashcard_deck).permit(:name, :description, flashcards_attributes: [:front, :back, :id, :_destroy])
    end
end
