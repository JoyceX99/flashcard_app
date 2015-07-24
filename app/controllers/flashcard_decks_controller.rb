class FlashcardDecksController < ApplicationController
  before_action :check_logged_in
  before_action :check_correct_user_custom, except: [:index, :show]

  # GET form for creating new flashcard deck
  def new
    @deck = FlashcardDeck.new
  end

  # POST new flashcard deck
  def create
    @deck = current_user.flashcard_decks.new(deck_params)
    if @deck.save
      #redirect_to user_flashcard_decks_path
      @user = @deck.user
      redirect_to @user
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
    @user = @deck.user
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
    @user = @deck.user
    @deck.destroy
    redirect_to @user
  end

  private
    def deck_params
      params.require(:flashcard_deck).permit(:name, :description, flashcards_attributes: [:front, :back, :id, :_destroy])
    end

    def find_deck_id
      @deck = FlashcardDeck.find(params[:id])
      return @deck.user.id
    end

    def check_correct_user_custom
      if !params[:user_id].nil?
        check_correct_user params[:user_id]
      else
        deck = FlashcardDeck.find(params[:id])
        user_id = deck.user.id
        check_correct_user user_id
      end
    end
end
