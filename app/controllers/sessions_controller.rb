class SessionsController < ApplicationController
  
  skip_before_filter :authenticate

  def new
  end

  def facebook
    auth_hash = request.env['omniauth.auth']
    user = User.new
    if authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      user = User.find(authorization.user_id)
      flash[:success] = 'Welcome back! You are already signed up.'
    elsif user = User.find_by(email: auth_hash["info"]["email"].downcase)
      user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
      flash[:success] = 'You have successfuly linked your account with Facebook!'
    else
      user = User.new :name => auth_hash["info"]["name"], :email => auth_hash["info"]["email"]
      user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
      user.save
      flash[:success] = 'You have successfuly signed up with Facebook!'
    end
    if user
      log_in user
      remember(user)
      redirect_to user
    else
      flash.now[:danger] = 'Failed to Authenticate.'
      render 'new'
    end
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
  		render 'new'
  	end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

  def failure
    flash.now[:danger] = 'Failed to login with facebook'
    render 'new'
  end

end