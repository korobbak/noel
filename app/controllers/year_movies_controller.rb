class YearMoviesController < ApplicationController
  def show
    if params[:id] == 2014
      boolean_movie "<="
    else
      boolean_movie "="
    end
    @movie_s = Movie.where("status_movie=true").sort_date
    @movie_coming_soon = []
    @movie.map do |m|
      if m.episodes.count == 0 || m.episodes.where("status_episode=false").count > 0
        @movie_coming_soon << m
      end
    end
    @movie_coming_soon = Kaminari.paginate_array(@movie_coming_soon).page(params[:page]).per 9
  end

  def boolean_movie compare
    @movie_a = Movie.get_movie_by_year(params[:id],compare).where("status_movie=true").sort_date
    @movie = []
    @movie_a.map do |m|
      if m.episodes.count > 0
        @movie << m
      end
    end
    @movie = Kaminari.paginate_array(@movie).page(params[:page]).per 24

    return if @movie
    flash.now[:error] = t "movie_type.error"
    redirect_to root_path
  end
end
