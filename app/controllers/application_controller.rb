class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private
    def check_logged_in
      unless logged_in?
        flash[:alert] = "Please log in first"
        redirect_to login_path
      end
    end

    def check_correct_user(param)
      @user = User.find(param) 
      #@user = User.find(params[:id]) || User.find(params[:user_id])
      unless @user == current_user
        flash[:alert] = "You must log in as a different user to proceed"
        redirect_to login_path
      end
    end

end
