class GenreMoviesController < ApplicationController
  def show
    @movie_type = MovieType.find_by(id: params[:id])
    @movie_a = MovieType.find_by(id: params[:id]).movie.where("status_movie=true").sort_date
     @movie = []
    @movie_a.map do |m|
      if m.episodes.count > 0
        @movie << m
      end
    end
    @movie = Kaminari.paginate_array(@movie).page(params[:page]).per 24
    @movie_s = Movie.where("status_movie=true").sort_date
    @movie_coming_soon = []
    @movie_s.map do |m|
      if m.episodes.count == 0
        @movie_coming_soon << m
      end
    end
  end
end
