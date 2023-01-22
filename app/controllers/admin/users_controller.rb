class Admin::UsersController < ApplicationController
  
  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @movies = @user.movies.page(params[:page])
    @comments = @user.comments.page(params[:page])
  end

  def edit
  end
  
end
