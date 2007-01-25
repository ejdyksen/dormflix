class HomeController < ApplicationController
  
  layout "main"
  
  def index
    if session[:user_id]
      @user = User.find(session[:user_id])
      @requests_in = []
      @user.movie_items.each do |item| item.requests.each do |request|
        @requests_in << request
      end
      end
    else
      @user = nil
    end
  end
  
  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:email], params[:password])
      if user
        if user.verification_key
        	flash[:notice] = "Your account has not been verified yet. Please check your email at <strong>" + user.email + "</strong> for more instructions." 
          redirect_to(request.env['HTTP_REFERER'])
        else
          session[:user_id] = user.id
          redirect_to(request.env['HTTP_REFERER'])
        end
      else
        flash[:notice] = "Invalid user/password combination"
        redirect_to(:action => "index", :email => params[:email])
      end
    end
  end
  
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(request.env['HTTP_REFERER'])
  end
  
end
