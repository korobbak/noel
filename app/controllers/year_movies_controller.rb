class YearMoviesController < ApplicationController
  def show
    if params[:id] == 2014
      boolean_movie "<="
    else
      boolean_movie "="
    end
    @movie_s = Movie.where("status_movie=true").sort_date
    @movie_coming_soon = []
    @movie_s.map do |m|
      if m.episodes.count == 0
        @movie_coming_soon << m
      end
    end
  end

  def boolean_movie compare
    @movie_a = Movie.get_movie_by_year(params[:id],compare).where("status_movie=true").sort_date
      .page(params[:page]).per(24)
    @movie = []
    @movie_a.map do |m|
      if m.episodes.count > 0
        @movie << m
      end
    end
    @movie = Kaminari.paginate_array(@movie).page(params[:page]).per 5

    return if @movie
    flash.now[:error] = t "movie_type.error"
    redirect_to root_path
  end
end
