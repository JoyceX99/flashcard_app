class UsersController < ApplicationController
  before_action :check_logged_in, only: [:show, :edit, :update, :destroy]
  before_action :check_correct_user, only: [:edit, :update, :destroy]   # can view other users' flashcards, but cannot modify

  def home
    if logged_in?
      redirect_to current_user
    else
      render 'home'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @decks = @user.flashcard_decks.order(id: :desc)
    render 'shared/_decks_home'
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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

    def check_logged_in
      unless logged_in?
        redirect_to login_path
      end
    end

    def check_correct_user
      @user = User.find(params[:id])
      redirect_to login_path unless @user == current_user
    end

end
