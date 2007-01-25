# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_dormflix_session_id'
  

  
  private
  
  def authorize
    unless User.find(session[:user_id])
      flash[:notice] = "Please log in or register"
      redirect_to(:controller => "home")
    end
    rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Please log in or register"
    redirect_to(:controller => "home")
  end
end
