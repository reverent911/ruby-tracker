class UserController < ApplicationController
	layout 'default'
	def index
		@current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
		if @current_user
			render :action => "index"
		else
			redirect_to :action => "login"
		end
	end

	def login 
		@user = User.new
	end

	def dologin
	    username_or_email = params[:user][:username]
	    password = params[:user][:password]

	    if username_or_email.rindex('@')
	      email=username_or_email
	      user = User.authenticate_by_email(email, password)
	    else
	      username=username_or_email
	      user = User.authenticate_by_username(username, password)
	    end

	    if user
	      session[:user_id] = user.id
	      flash[:notice] = 'Welcome.'
	      redirect_to :root
	    else
	      flash.now[:error] = 'Login Failed. Please check your username and password and try again.'
	      render :action => "login"
	    end
  	end

end
