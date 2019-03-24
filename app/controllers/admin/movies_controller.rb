class Admin::MoviesController < ApplicationController
  before_action :logged_in_admin, only: %i(index create new)
  before_action :list_movie_type, only: %i(edit create new)
  layout "admin"

  def index
    @movies = Movie.check_status_movie.sort_date.page(params[:page]).per 5
    @episodes = Episode.where("status_episode=false").sort_date.page(params[:page]).per 5
  end

  def show
    @movies_show = Movie.where("status_movie=true").sort_date.page(params[:page]).per 5
  end

  def new
    @movie = Movie.new
    @movie.movie_objects.build
  end

  def create
    @movie = current_user.movies.build(movie_params)
    if @movie.save
      flash.now[:success] = "Thành công"
      redirect_to admin_index_path
    else
      flash.now[:danger] = "Lỗi vui lòng thêm lại"
      render :new
    end
  end

  def update_movie
    @movie = Movie.find_by id: params[:id]
    if @movie.status_movie == false
      @movie.update status_movie: true
      redirect_to admin_movie_path(1)
    else
      @movie.update status_movie: false
      redirect_to admin_index_path
    end
  end

  def list_movie_type
    @list = MovieType.all.map{|e| [e.name, e.id]}
  end

  def destroy
    @movie = Movie.find_by id: params[:id]
    @movie.destroy
    redirect_to request.referer
  end

  private

  def movie_params
    params.require(:movie)
      .permit :name, :content, :total_episodes, :image_url, :producer_name, movie_objects_attributes: [:id, :movie_type_id]
  end

  def logged_in_admin
    return false if logged_in?
    redirect_to login_url
  end
end
