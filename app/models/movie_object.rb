class MovieObject < ApplicationRecord
  belongs_to :movie
  belongs_to :movie_type
end
