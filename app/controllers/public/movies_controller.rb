class Public::MoviesController < ApplicationController
before_action :authenticate_user!

  def index
    if params[:latest]
      @movies = Movie.page(params[:page]).latest.per(8)
      @genres = Genre.all
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @movies = @genre.movie.page(params[:page]).latest.per(8)
    end
    elsif params[:old]
      @movies = Movie.page(params[:page]).old.per(8)
      @genres = Genre.all
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @movies = @genre.movie.page(params[:page]).old.per(8)
    end
    elsif params[:star_count]
      @movies = Movie.page(params[:page]).star_count.per(8)
      @genres = Genre.all
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @movies = @genre.movie.page(params[:page]).star_count.per(8)
    end
    elsif params[:horror_count]
      @movies = Movie.page(params[:page]).horror_count.per(8)
      @genres = Genre.all
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @movies = @genre.movie.page(params[:page]).horror_count.per(8)
    end
    else
      @movies = Movie.page(params[:page]).order(created_at: :desc).per(8)
      @genres = Genre.all
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @movies = @genre.movie.page(params[:page]).order(created_at: :desc).per(8)
    end
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @comments = @movie.comments.page(params[:page])
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
