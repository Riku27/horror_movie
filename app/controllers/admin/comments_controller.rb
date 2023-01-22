class Admin::CommentsController < ApplicationController
    
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_users_path
  end
  
end
