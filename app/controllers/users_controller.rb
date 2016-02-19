class UsersController < ApplicationController

  skip_before_filter :authenticate

  def show
    redirect_to login_path unless logged_in?
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "You have successfuly signed up!"
      redirect_to(session[:return_to] || @user)
      session.delete(:return_to)
    else
      render 'new'
    end
  end
  
private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
    
end
