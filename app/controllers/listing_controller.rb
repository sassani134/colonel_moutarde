class ListingController < ApplicationController
  require 'bigdecimal'
  require 'bigdecimal/util'
  include SharedComment

  def index 
    @games = Game.where(:confirm => true)
    @users = User.all
    @genres = Genre.all
    @copies = Copy.where(:available => true).order(1)
    if user_signed_in?
      @cart=Cart.where(:user_id => current_user.id)[0]
      if @cart
        @cart
      else
        @cart = Cart.create!(user_id: current_user.id)
      end
    end
  end

  def show
    @good_comment = Comment.new
    @good_coms = []
    @game= Game.find(params[:id])
    if user_signed_in?
      @copies_other_users = @game.copies.where.not(:user_id => current_user.id)
      @copies = @copies_other_users.where(:available =>true)
      @cart=Cart.where(:user_id => current_user.id)[0]
    else
      @copies = @game.copies.where(:available =>true)
    end
    @users = User.all
    @genres = Genre.all
    @game = Game.find(params[:id])
    @long = []
    @lat = []
    @proprio = []
    @copies.each do |copy|
    	@lat << copy.latitude
    	@long << copy.longitude
      @proprio << copy.user.username
      @copy = copy.id.to_s
    end
  end

  def resume
    if current_user.admin?
      @orders = Order.all
      @users = User.all
      @amount = 0
      @orders.each do |order|
        @amount += order.price.to_i
      end
    else
      redirect_to root_path
    end
  end

  def past_orders
    if user_signed_in?
      @orders=current_user.orders
    else
      redirect_to root_path
    end
  end

  def toggle_past
    @order = Order.find(params[:id])
  end

end
