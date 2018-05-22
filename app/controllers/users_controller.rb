class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save # If we are successful in saving the user,
      redirect_to root_path # Sends user back to the homepage once the signup is completed successfully
    else
      render :new # Sends user back to the create new user page if unable to set up new user properly
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
