class Admin::GenresController < ApplicationController

  before_action :authenticate_admin!

  def index
    @genres = Genre.page(params[:page]).per(8)
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def create
    @genres = Genre.all
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    redirect_to admin_genres_path
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.delete
    redirect_to admin_genres_path
  end

private
  def genre_params
    params.require(:genre).permit(:name)
  end

end