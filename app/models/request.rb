class Request < ActiveRecord::Base
  belongs_to :movie_item
  belongs_to :user
end
