class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  include SessionsHelper

	before_filter :authenticate

	def authenticate
	  deny_access unless logged_in?
	end 

	def deny_access
	  store_location
	  flash[:danger] = 'Please log in to access this page.'
	  redirect_to login_path
	end

	def store_location
	  session[:return_to] = request.fullpath
	end

end
