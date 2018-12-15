# frozen_string_literal: true

class DashboardController < ApplicationController

  respond_to? :html, :js

  def index
    @all_copies = current_user.copies
    @renting_copies = current_user.copies.where(rented: true)
    @unconfirmed_copies = @renting_copies.where(return: nil)
    @confirmed_copies = @renting_copies.where.not(return: nil)
    @cart = Cart.where(user_id: current_user.id)
    @past_orders = current_user.orders
    @active_orders = @past_orders.where("'true' = ANY (renting)")
    @games = Game.all
    @title = []
    @games.each do |game|
      @title << game.title
    end
    if user_signed_in?
      @cart = Cart.where(user_id: current_user.id)[0]
      @cart || @cart = Cart.create!(user_id: current_user.id)
      @price = 0
      if @cart.copy_ids[0]
        @cart.copy_ids.each_with_index do |_content, index|
          @price += 3.5 * @cart.number_week[index]
        end
      end
      @price
    end
  end

  def rent_copy
    @games = Game.all
    @title = []
    @games.each do |game|
      @title << game.title
    end
  end

  def confirm
    @game = Game.find(params[:id])
    @game.confirm = true
    if @game.save
      redirect_to '/admin'
    else
      redirect_to root_path
    end
  end

  def save_copy
    @address = [params[:anything][:street], params[:anything][:city], params[:anything][:postal_code], params[:anything][:country]].compact.join(', ')
    @game = Game.where(title: params[:anything][:game])[0]
    @copy = Copy.new(user: current_user, game: @game, address: @address, available: true, return: nil, rented: false)
    if @copy.save
      redirect_to '/dashboard'
    else
      redirect_to '/rent_copy'
    end
  end

  def available_copy
    @all_copies = current_user.copies
    @copy = Copy.find(params[:id])
    if @copy.user == current_user && @copy.rented == false
      @copy.toggle(:available)
      @copy.save
    end
    @copy
  end

  def confirm_copy
    @copy = Copy.find(params[:id])
    if @copy.user == current_user && @copy.rented == true
      @ind = @copy.orders.last.copy_ids.index(params[:id].to_i)
      @weeks = @copy.orders.last.number_week[@ind]
      @copy.return = (Time.now + @weeks.week).to_date
      @copy.save
      @user_renting = @copy.orders.last.user
      UserMailer.client_receive(@user_renting, @copy, @weeks).deliver_now!
      redirect_to '/dashboard'
    else
      redirect_to '/dashboard'
    end
  end

  def return_copy
    @copy = Copy.find(params[:id])
    if @copy.user == current_user && @copy.rented == true
      @copy.rented = false
      @copy.return = nil
      @copy.save
      @order = @copy.orders.last
      @ind = @order.copy_ids.index(params[:id].to_i)
      @order.renting[@ind] = false
      @order.save
      redirect_to '/dashboard'
    else
      redirect_to root_path
    end
  end

  def toggle_past
    @order = Order.find(params[:id])
  end
end
