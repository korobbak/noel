class DetailMoviesController < ApplicationController
  def show
    @movie = Movie.find_by(id: params[:id])
    @movie_type = MovieType.find_by(name: @movie.movie_types.sample.name).movie.where("status_movie=true").sort_date
    @episode = Movie.find_by(id: params[:id]).episodes.select("id").where("status_episode=true").order("created_at ASC")

    if !current_user.nil?
      @movie_like = []
      Movie.find_by(id: params[:id]).user_like_movies.map do |a|
        if !current_user.user_like_movies.find_by(id: a.id).nil?
          @movie_like << current_user.user_like_movies.find_by(id: a.id)
        end
      end
    end
  end

  def insert
    @movie_like = UserLikeMovie.new
    @movie_like = current_user.user_like_movies.build(movie_id: params[:id])
    if @movie_like.save
      redirect_to request.referer
    end
  end

  private
end
