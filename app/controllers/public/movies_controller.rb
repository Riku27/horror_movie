class Public::MoviesController < ApplicationController
before_action :authenticate_user!

  def index
    @movies = Movie.page(params[:page]).order(created_at: :desc)
    @genres = Genre.all
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @movies = @genre.movie.page(params[:page]).order(created_at: :desc)
    end
  end

  def show
    @comments = Comment.page(params[:page])
    @movie = Movie.find(params[:id])
    @comment = Comment.new
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user_id = current_user.id
    if @movie.save
      redirect_to '/public/my_page'
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update(movie_params)
    redirect_to '/public/my_page'
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.delete
    redirect_to '/public/my_page'
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :year, :director, :watch, :rate, :rate_horror, :genre_id)
  end

  #def is_matching_login_user
    #@movie = Movie.find(params[:id])
    #unless @movie.user == current_user
      #redirect_to movies_path
    #end
  #end

end
