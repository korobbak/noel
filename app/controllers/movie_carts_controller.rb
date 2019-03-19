class MovieCartsController < ApplicationController
  def index
    @movie = []
    if !current_user.nil?
      if !current_user.user_like_movies.nil?
        current_user.user_like_movies.map do |m|
          @movie << m.movie
        end
      end
    end
    @movie = Kaminari.paginate_array(@movie).page(params[:page]).per 24

    @movie_s = Movie.where("status_movie=true").sort_date
    @movie_coming_soon = []
    @movie.map do |m|
      if m.episodes.count == 0 || m.episodes.where("status_episode=false").count > 0
        @movie_coming_soon << m
      end
    end
    @movie_coming_soon = Kaminari.paginate_array(@movie_coming_soon).page(params[:page]).per 9
  end

  def destroy
    Movie.find_by(id: params[:id]).user_like_movies.map do |a|
      @movie_like = current_user.user_like_movies.find_by(id: a.id)
    end

    @movie_like.destroy

    redirect_to request.referer
  end
end
