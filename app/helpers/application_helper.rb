# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def flash_helper
  
    f_names = [:notice, :warning, :message]
    fl = ''
    
    for name in f_names
      if flash[name]
        fl = fl + "<div class=\"flash\" id=\"#{name}\"><p>#{flash[name]}</p></div>"
      end
      flash[name] = nil;
    end
    return fl
  end
  
  def first_name
    if session[:user_id]
      User.find(session[:user_id]).first_name
    else
      nil
    end
  end
end
