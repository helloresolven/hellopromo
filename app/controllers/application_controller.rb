class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :logged_in?
  
  protected
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
  
  def logged_in?
    !! current_user
  end
  
  def require_login
    unless logged_in?
      session[:return_to] = request.path
      redirect_to signin_path unless logged_in?
    end
  end
end
