class Public::UsersController < ApplicationController

  #before_action :is_matching_login_user, only: [:edit, :update]
  before_action :authenticate_user!

  def index

  end

  def show
    @user = current_user
    #@movies = Movie.all
    @movies = @user.movies.page(params[:page]).order(created_at: :desc)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
    redirect_to public_my_page_path(current_user)
    else 
    render :edit
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end

  #def is_matching_login_user
    #@movie = Movie.find(params[:id])
    #unless @movie.user == current_user
      #redirect_to movies_path
    #end
  #end

end
