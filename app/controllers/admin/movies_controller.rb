class Admin::MoviesController < ApplicationController
  def index
  end

  def show
  end
  
  def destroy
    @movie = Movie.find(params[:id])
    @movie.delete
    redirect_to admin_users_path
  end
end
