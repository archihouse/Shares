class SessionController < ApplicationController
  def new
  end

  def create # Start the User Session upon login
    @user = User.find_by :email => params[:email] # Find the user based on the email input, set up to find by email instead of user id
    if @user.present? && @user.authenticate(params[:password]) # Check if the login email is valid and also password autheniticates compared to digest
      session[:user_id] = @user.id # When email and password is valid, remember used id in session across multiple pages
      redirect_to root_path
    else
      flash[:error] = "Invalid email or password" # If password doesn't authenticate, send back to login page with invalid message
      redirect_to login_path # Flash is a session that only lasts for one page - so remembers to provide error message for one page session
    end
  end

  def destroy # End the User Session upon logout
    session[:user_id] = nil # No longer remember the user id once customer is logged out
    redirect_to login_path # Redirected to the login page
  end
end
