class UsersController < ApplicationController

  skip_before_filter :authenticate

  def show
    redirect_to login_path unless logged_in?
    @user = User.find(params[:id])
    @user_uploads = Upload.find_by_user_id(params[:id])
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

  def edit
  end

  def update
    @user = User.find(current_user.id)
    if @user && (!@user.password_digest || @user.authenticate(params["user"][:current_password]))
      if @user.update(user_updated_params)
        log_in @user
        flash[:success] = "You have successfuly changed your information!"
        redirect_to @user
      else
        flash[:danger] = "Failed to update values."
        render "edit"
      end
    else
      flash[:danger] = "Wrong Password!"
      render "edit"
    end
  end
  
private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def user_updated_params
    params.require(:user).permit(:name, :password,
                                 :password_confirmation)
  end

end
