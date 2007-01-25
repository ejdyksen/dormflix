module BrowseHelper
  
  def i_own_this(movie)
    ret = false
    movie.users.each do |user|
      ret = true if user.id == session[:user_id]
    end
    ret
  end
  
  def current_user
    User.find(session[:user_id])
  end
  
end
