class ListingController < ApplicationController
  require 'bigdecimal'
  require 'bigdecimal/util'
  def index
    @games = Game.all
    @genres = Genre.all
  end

  def show
    @game = Game.find(params[:id])
    @copies = @game.copies.where.not(:user_id => current_user.id)
    @long = []
    @lat = []
    @proprio = []
    @copies.each do |copy|
    	@lat << copy.latitude
    	@long << copy.longitude
      @proprio << copy.user.username
    end
    
  end


end
