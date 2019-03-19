class Post::EpisodesController < ApplicationController
  before_action :search_episode, only: %i(edit update)
  layout "post"

  def new
    @movie = Movie.find_by id: params[:id]
    @episode = @movie.episodes.build
  end

  def create
    @episode = Episode.new(episode_params)
    @movie = Movie.find_by id: episode_params[:movie_id]

    if @episode.save
      flash[:success] = "Thêm thành công"
    else
      flash[:danger] = "Thêm thất bại"
    end
    redirect_to request.referer
  end

  def index
    @movies_show = current_user.movies.where("status_movie=true").sort_date.page(params[:page]).per 5

    @episodes = []
    if !@movies_show.nil?
      @movies_show.map do |m|
        @episodes += m.episodes.where "status_episode = ?", true
      end
    end

    @episodes = Kaminari.paginate_array(@episodes).page(params[:page]).per 5
  end

  def edit; end

  def update
    if @episode.update episode_params_1
      flash[:success] = "Sửa thành công"
      redirect_to request.referer
    else
      flash[:danger]= "Sửa thất bại"
      render :edit
    end
  end

  def destroy
    @episode = Episode.find_by id: params[:id]
    @episode.destroy
    flash[:success] = t "admin.episodes.destroy.success"
    redirect_to request.referer
  end

  private

  def episode_params
    params.require(:episode)
          .permit :name, :episode_url, :movie_id
  end
  def episode_params_1
    params.require(:episode)
          .permit :name, :episode_url
  end

  def search_episode
    @episode = Episode.find_by id: params[:id]
    @movie = Movie.find_by id: @episode.movie_id
  end
end
