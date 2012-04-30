class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_uid(auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    
    redirect_to (session[:return_to] || profile_path), :notice => "Signed in!"
  end
  
  def failure
    redirect_to root_path, :notice => "Failed to login!"
  end
  
  def destroy
    session[:user_id] = nil
    reset_session
    
    redirect_to root_path, :notice => "Signed out!"
  end
end
