class BorrowController < ApplicationController
  layout "main"
  
  before_filter :authorize
  
  def index
    step1
    render :action => "step1"
  end
  
  def step1
    @movie = Movie.find(params[:id])
  end
  
  def step2
    now = Time.now
    
    item = MovieItem.find(params[:id])
    
    @request = Request.new
    @request.user_id         = session[:user_id]
    @request.movie_item_id   = item.id
    @request.checked_out     = now
    @request.due_date        = 6.days.from_now
    @request.complete        = false
    @request.save
    
    item.available = false;
    item.update
    
  end
  
  def remove
    request = Request.find(params[:id])
    request.movie_item.available = true
    request.movie_item.update
    Request.destroy(params[:id])
  end
end
