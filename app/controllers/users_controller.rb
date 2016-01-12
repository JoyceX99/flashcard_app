class UsersController < ApplicationController
  before_action :check_logged_in, only: [:show, :edit, :update, :destroy]
  #before_action :check_correct_user, only: [:edit, :update, :destroy]   # can view other users' flashcards, but cannot modify
  before_action -> { check_correct_user params[:id] }, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:notice] = "Welcome to your NightFlash!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @decks = @user.flashcard_decks.order(id: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "Updated account information"
      redirect_to @user
    else
      flash.now[:alert] = "Error updating account"
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation);
    end

end
