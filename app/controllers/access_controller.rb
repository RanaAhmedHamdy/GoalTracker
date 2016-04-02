class AccessController < ApplicationController

  before_action :confirm_logged_in, :except =>[:login, :attempt_login, :logout, :index, :signup, :attempt_signup]

  def index
  end

  def login
  end

  def attempt_login
  	if params[:email].present? && params[:password].present?
  		founduser = User.where(:email => params[:email]).first
  		if founduser
  			authorized_user = founduser.authenticate(params[:password])
  		end
  	end
  	if authorized_user
  		session[:user_id] = authorized_user.id
  		session[:email] = authorized_user.email
  		#flash[:notice] = "You are logged in"
  		flash[:notice] = " "
  		redirect_to(:action => 'index', :controller => 'goals')
  	else
  		flash[:notice] = "Invalid email or password"
  		redirect_to(:action => 'login')
  	end
  end

  def logout
  	session[:user_id] = nil
  	session[:email] = nil
  	redirect_to(:action => 'login')
  end

  def signup
  	@user = User.new({:first_name => ""})
  end

  def attempt_signup
  	# instantiate a new obj
    @user = User.new(user_params)
    # save the object
    if @user.save
      # if save succeeds, redirect to index action
      #flash[:notice] = "User created successfully"
      redirect_to(:action => 'index', :controller => 'goals')
    else
      # if save fails, redisplay the form so user can fix problems
      render('signup')
    end
  end

  private
    def user_params
      #raises an error if :subject not present
      #allow listed attributes to be mass-assigned
      params.require(:user).permit(:first_name, :last_name, :country, :email, :password, :password_confirmation)
    end
end
