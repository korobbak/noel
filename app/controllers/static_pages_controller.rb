class StaticPagesController < ApplicationController
  def home
    @movie = Movie.where("status_movie=true").sort_date
    @movie_new = []
    @movie.map do |m|
      if m.episodes.count > 0
        @movie_new << m
      end
    end
    @movie_s = Movie.where("status_movie=true and total_episodes>25").sort_date
    @movie_series = []
    @movie_s.map do |m|
      if m.episodes.count > 0
        @movie_series << m
      end
    end
    @movie_coming_soon = []
    @movie.map do |m|
      if m.episodes.count == 0
        @movie_coming_soon << m
      end
    end
  end
end
