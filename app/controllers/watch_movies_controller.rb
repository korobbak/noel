class WatchMoviesController < ApplicationController
  def show
    @movie = Episode.find_by(id: params[:id]).movie
    @episode_show = Episode.find_by(id: params[:id])
    @episode = @movie.episodes.where("status_episode = ?", true).order("created_at ASC")
    @comments = @movie.comments
      .order("created_at DESC").page(params[:page]).per 5
    @comment = @movie.comments.build
  end
end
