class BrowseController < ApplicationController
  layout "main"
  
  before_filter :authorize
  
  def index
    @movies = Movie.find(:all)
  end
  
  def expand
    @movie = Movie.find(params[:id])
    render :partial => "browse/movie_list_expanded", :object => @movie, :layout => false
  end
  
  def collapse
    @movie = Movie.find(params[:id])
    render :partial => "browse/movie_list_collapsed", :object => @movie, :layout => false
  end
  
  def search
    unless params[:search].blank?
      case params[:type]
        when "list"
          render :partial => "movie_list", :collection => Movie.find(:all, :conditions => ["title like ?", "%" + params[:search] + "%"]), :layout => false
        when "table"
          render :partial => "movie_table", :object => Movie.find(:all, :conditions => ["title like ?", "%" + params[:search] + "%"]), :layout => false
        else
          render :partial => "movie_list", :collection => Movie.find(:all, :conditions => ["title like ?", "%" + params[:search] + "%"]), :layout => false
      end
    else
      case params[:type]
        when "list"
          render :partial => "movie_list", :collection => Movie.find(:all), :layout => false
        when "table"
          render :partial => "movie_table", :object => Movie.find(:all), :layout => false
        else
          render :partial => "movie_list", :collection => Movie.find(:all), :layout => false
      end
    end
  end
end
