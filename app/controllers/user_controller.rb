class UserController < ApplicationController
  def index
    @rented_copies = current_user.copies.where(:rented => false)
    #@confirmed_copies = @rented_copies.orders.where(:rented => false)
    #@unconfirmed_copies = @rented_copies.where(:rented => false)
    @renting_copies = current_user.copies.where(:rented => true)
    @cart=Cart.where(:user_id => current_user.id)
    @orders=current_user.orders
    
  end

  def add_game
    @games = Game.all
    @title=[]
    @games.each do |game|
      @title << game.title
    end
  end

  def save_game
  end
end

