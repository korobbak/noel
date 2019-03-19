class Post::MoviesController < ApplicationController
  before_action :list_movie_type, only: %i(edit create new)
  layout "post"

  def index
    @movies = current_user.movies.check_status_movie.sort_date.page(params[:page]).per 5
    @movies_show = current_user.movies.where("status_movie=true").sort_date.page(params[:page]).per 5

    @episodes = []
    if !@movies_show.nil?
      @movies_show.map do |m|
        @episodes += m.episodes.where "status_episode = ?", false
      end
    end

    @episodes = Kaminari.paginate_array(@episodes).page(params[:page]).per 3
  end

  def show
    @movies_show = current_user.movies.where("status_movie=true").sort_date.page(params[:page]).per 5
  end

  def new
    @movie = Movie.new
    @movie.movie_objects.build
  end

  def create
    @movie = current_user.movies.build(movie_params)
    if @movie.save
      flash.now[:success] = "Thành công"
      redirect_to post_index_path
    else
      flash.now[:danger] = "Lỗi vui lòng thêm lại"
      render :new
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
end
