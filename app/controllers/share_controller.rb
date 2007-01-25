require "amazon/search"

class ShareController < ApplicationController
  
  include Amazon::Search
  
  DEV_TOKEN = "0JSHEFG5PMYRCTT02DR2"
  
  layout "main"
  
  before_filter :authorize
  
  def index
    @message = "Enter the title of your movie"
  end
  
  
  def add
    @message = "Enter the title of your movie"
    if params[:id]
      movie = Movie.find(params[:id])
      user = User.find(session[:user_id])
      unless user.nil? || movie.nil?
        item = MovieItem.new
        item.user_id = user.id
        item.movie_id = params[:id]
        item.save
        redirect_to(request.env['HTTP_REFERER'])
        flash[:notice] = movie.title + " has been to your movie collection!"
      else
        
      end
    end
    if params[:asin]
      user = User.find(session[:user_id])
      unless user.nil?
        
        item = MovieItem.new
        movie = Movie.copy_from_amazon(params[:asin])
        item.user_id = user.id
        item.movie_id = movie.id
        item.save
        redirect_to(request.env['HTTP_REFERER'])
        flash[:notice] = movie.title + " has been added to our database, and it has been added to your movie collection!"
      end
    end
  end
  
  def remove
    if params[:movie_id] && params[:user_id]
      MovieItem.destroy_all(["user_id = ? and movie_id = ?", params[:user_id], params[:movie_id]])
      if MovieItem.find(:all, :conditions => ["movie_id = ?", params[:movie_id]]).empty?
        Movie.destroy(params[:movie_id])
      end
      render_text ""
    end
  end
  
  def amazon_test
    request  = Request.new(DEV_TOKEN)
    response = request.asin_search(params[:asin])
    product = response.products[0]
    
    message = product.to_s
    
    render_text message
  end
  
  # AJAX METHODS
  
  def amazon_search
    unless params[:search].blank?
      begin
        request = Request.new(DEV_TOKEN)
        response = request.keyword_search(params[:search], "video")
        products = response.products
        render :partial => "movie_list_amazon", :collection => products, :layout => false
      rescue
        render :partial => "movie_list_amazon", :layout => false
      end
    else
      render :partial => "movie_list_amazon", :layout => false
    end
  end
  
  def add_search
    unless params[:search].blank?
      render :partial => "movie_list_add", :collection => Movie.find(:all, :conditions => ["title like ?", "%" + params[:search] + "%"]), :layout => false
    else
      render :partial => "movie_list_add", :layout => false
    end
  end
end
