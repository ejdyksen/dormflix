class RegisterController < ApplicationController
  
  def index
    @sucess = false
    @user = User.new(params[:user])
    if request.post?
      s=""
      10.times { s << (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }
      @user.verification_key = s
      if @user.save
        @sucess = true
      end      
    end
  end
  
  
  def verify
    user = User.find(:first, :conditions => ["verification_key = ?", params[:key]])
    @verified = false
      if user.verification_key.nil?
        @message = "You are already verified"
      else
        if params[:key] == user.verification_key
          user.update_attribute(:verification_key, nil)
          @verified = true
          session[:user_id] = user.id
          @message = "You're verified!"
        else
          @message = "Incorrect verification key. Please check your email at <strong>" + user.email + "</strong> for more instructions."
        end
      end
  end
  
  
end
