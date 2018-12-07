class ListingController < ApplicationController

  def index 
    @games = Game.all
    @users = User.all
    @genres = Genre.all
    @copies = Copy.order(1)
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
    @copies = Copy.all
    @users = User.all
    @game = Game.find(params[:id])
    @copy= Copy.find(params[:id])
    if user_signed_in?
      @cart=Cart.where(:user_id => current_user.id)[0]
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
