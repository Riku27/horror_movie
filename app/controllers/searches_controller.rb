class SearchesController < ApplicationController
    
  before_action :authenticate_user!
    
   def index
    @range = params[:range]
    @movies = Movie.looks(params[:search], params[:word]).page(params[:page]).per(8)
    @movie = params[:tag_id].present? ? Tag.find(params[:tag_id]).movies: Movie.all
   end
   
end
