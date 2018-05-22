class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :fetch_user # runs code before any controller is run

  private
  def fetch_user # Set up a current user variable
    @current_user = User.find_by :id => session[:user_id] if session[:user_id].present? # Find user id and define to current user variable if user is logged in
    session[:user_id] = nil unless @current_user.present? # Get rid of session id once user logs off and is no longer present
  end
end
