class ListingController < ApplicationController

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @copies = Game.copies.where.not(:user_id => current_user.id)
  end


end
