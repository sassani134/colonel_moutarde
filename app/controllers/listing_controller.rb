# frozen_string_literal: true

class ListingController < ApplicationController
  respond_to? :html, :js

  def index
    @games = Game.where(confirm: true)
    @users = User.all
    @genres = Genre.all
    if user_signed_in?
      @cart = Cart.where(user_id: current_user.id)[0]
      @cart || @cart = Cart.create!(user_id: current_user.id)
    end
  end

  def search_game
    redirect_to "/listing/#{params[:id]}"
  end

  def search_cat
    @category_search = Category.where(genre_id: params[:id])
    @games = []
    @category_search.each do |cat|
      @games << cat.game if cat.game.confirm == true
    end
    @users = User.all
    @genres = Genre.all
    @cart = Cart.where(user_id: current_user.id)[0] if user_signed_in?
  end

  def show
    @game = Game.find(params[:id])
    @games = Game.where(confirm: true)
    if user_signed_in?
      @copies_other_users = @game.copies.where.not(user_id: current_user.id)
      @copies = @copies_other_users.where(available: true)
      @cart = Cart.where(user_id: current_user.id)[0]
    else
      @copies = @game.copies.where(available: true)
    end
    @users = User.all
    @genres = Genre.all
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
      @orders = current_user.orders
    else
      redirect_to root_path
    end
  end

  def toggle_past
    @order = Order.find(params[:id])
  end

  include SharedComment
end
