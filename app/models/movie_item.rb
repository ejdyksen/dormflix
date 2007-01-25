class MovieItem < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user
  has_many :requests
end
