class SearchsController < ApplicationController
  def index
    @movie_a = Movie.search_movie_by_name(params[:search]).where("status_movie=true").sort_date
    @movie = []
    if !@movie_a.nil?
      @movie_a.map do |m|
        if m.episodes.count >= 0
          @movie << m
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
end
