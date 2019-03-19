class MovieType < ApplicationRecord
  has_many :movie_objects
  has_many :movie, through: :movie_objects
end
