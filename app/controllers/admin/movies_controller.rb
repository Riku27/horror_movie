class Admin::MoviesController < ApplicationController
  
  before_action :authenticate_admin!
  
  def index
    @movies = Movie.page(params[:page]).order(created_at: :desc)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.delete
    redirect_to admin_users_path
  end
end
