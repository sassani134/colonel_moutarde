class DashboardController < ApplicationController

  def index
    @rented_copies = current_user.copies.where(:rented => false)
    #@confirmed_copies = @rented_copies.orders.where(:rented => false)
    #@unconfirmed_copies = @rented_copies.where(:rented => false)
    @renting_copies = current_user.copies.where(:rented => true)
    @cart=Cart.where(:user_id => current_user.id)
    @past_orders=current_user.orders
    @active_orders=@past_orders.where("'true' = ANY (renting)")
  end

  def add_game
    @games = Game.all
    @title=[]
    @games.each do |game|
      @title << game.title
    end
  end

  def save_game
    @address = [params[:anything][:street], params[:anything][:city], params[:anything][:postal_code], params[:anything][:country].compact.join(', ')
    @game = Game.where(:title => params[:anything][:game])
    @copy = Copy.new(user:current_user, game: @game, address:@address, available: true, return:nul, rented:false)
    if @copy.save
      redirect_to root_path
    else 
      redirect-to "/add_game"
    end
  end
  
  def toggle_past
  @order = Order.find(params[:id])
  end
end

