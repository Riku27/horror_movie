class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
  end

  def about
    @users = User
  end
end
