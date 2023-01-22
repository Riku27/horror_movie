class Public::CommentsController < ApplicationController

  def create
    @movie = Movie.find(params[:movie_id])
    comment = current_user.comments.new(comment_params)
    comment.movie_id = @movie.id
    if comment.save
       render :create
    else
      # @movie = Movie.find(params[:movie_id])
       @comment = Comment.new
       render 'public/movies/show'
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to public_movie_path(params[:movie_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
