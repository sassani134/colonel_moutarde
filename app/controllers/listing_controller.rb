class ListingController < ApplicationController

  def index
    @games = Game.all
    @genres = Genre.all
  end

  def show
    @game = Game.find(params[:id])
    @copies = @game.copies.where.not(:user_id => current_user.id)
  end


end
