require "amazon/search"

class Movie < ActiveRecord::Base

  include Amazon::Search

  DEV_TOKEN = "redacted"

  has_many :movie_items
  has_many :users, :through => :movie_items


  validates_presence_of :title, :asin

  validates_uniqueness_of :asin, :upc

  serialize :directors

  def Movie.copy_from_amazon(asin)
    request  = Request.new(DEV_TOKEN)
    response = request.asin_search(asin)
    product = response.products[0]

    movie = Movie.new

    movie.title                   = product.product_name
    movie.asin                    = product.asin
    movie.upc                     = product.upc
    movie.directors               = product.directors
    movie.image_url_small         = product.image_url_small
    movie.image_url_medium        = product.image_url_medium
    movie.image_url_large         = product.image_url_large
    movie.mpaa_rating             = product.mpaa_rating
    movie.description             = product.product_description
    movie.theatrical_release_date = product.theatrical_release_date

    movie.save

    return movie
  end

end
