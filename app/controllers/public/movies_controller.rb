class Public::MoviesController < ApplicationController
before_action :authenticate_user!

  def index
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      session[:genre_id] = params[:genre_id]
    elsif session[:genre_id].present?
      @genre = Genre.find(session[:genre_id])
    else
      @genre = Genre.first
    end

    if params[:tag_id].present?
      @movies = Movie.joins(:movie_tags).where(genre_id: @genre.id).where("movie_tags.tag_id = ?", params[:tag_id])
    else
      @movies = Movie.where(genre_id: @genre.id)
    end
    
    if params[:latest]
      @movies = @movies.page(params[:page]).latest.per(8)
    elsif params[:old]
      @movies = @movies.page(params[:page]).old.per(8)
    elsif params[:star_count]
      @movies = @movies.page(params[:page]).star_count.per(8)
    elsif params[:horror_count]
      @movies = @movies.page(params[:page]).horror_count.per(8)
    else
      @movies = @movies.page(params[:page]).order(created_at: :desc).per(8)
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
    @movie.destroy
    redirect_to '/public/my_page'
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :year, :director, :watch, :rate, :rate_horror, :genre_id, tag_ids: [])
  end

  #def is_matching_login_user
    #@movie = Movie.find(params[:id])
    #unless @movie.user == current_user
      #redirect_to movies_path
    #end
  #end

end
