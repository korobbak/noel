class CommentsController < ApplicationController
  def create
    @comment = Comment.new comment_params
    @movie = Movie.find_by id: comment_params[:movie_id].to_i

    @comments = @movie.comments.sort_date.page(params[:page]).per 5

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment}
        format.js
        format.json { render :show, status: :created, location: @comment }
      end
    end
  end

  def destroy
    @comment = Comment.find_by id: params[:id]
    @comment.destroy
    @movie = Movie.find_by id: @comment.movie.id

    @comments = @movie.comments.sort_date.page(params[:page]).per 5

    respond_to do |format|
        format.html { redirect_to comments_url }
        format.json { head :no_content }
        format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :comment_image, :movie_id, :user_id
  end
end
