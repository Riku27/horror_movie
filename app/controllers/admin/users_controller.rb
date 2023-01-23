class Admin::UsersController < ApplicationController
  
  before_action :authenticate_admin!
  
  def index
    @users = User.page(params[:page]).per(8)
  end

  def show
    @user = User.find(params[:id])
    @movies = @user.movies.page(params[:page])
    @comments = @user.comments.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_users_path
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :is_deleted)
  end
  
end
