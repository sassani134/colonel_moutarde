# frozen_string_literal: true

class ChargesController < ApplicationController
  def new
    if user_signed_in?
      @cart = Cart.where(user_id: current_user.id)[0]
      @game_rented = ""
      @cart.copies.each_with_index do |copy, index|
        if copy.rented == true
          @game_rented = @game_rented + "#{copy.game.title} en position #{index+1}, "
        end
      end

      if @game_rented[0]
        redirect_to '/dashboard'
        flash[:alert] = "Le(s) jeu(x) #{@game_rented} du panier est (sont) actuellement louée, veuillez en prendre d'autres"
      else
        get_price
      end
    end 
  end

  def create
    # Price in cents to convert
    get_price

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @convert_price,
      description: 'Rails Stripe customer',
      currency: 'eur'
    )

    checkout
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private

  def get_price
    @cart = Cart.where(user_id: current_user.id)[0]
    @price = 0
    @cart.copy_ids.each_with_index do |_content, index|
      @price += 3.5 * @cart.number_week[index]
    end
    @price
    @convert_price = @price.to_i * 100
    @convert_price2 = @price * 100
  end

  def checkout
    if user_signed_in?
      @cart = Cart.where(user_id: current_user.id)[0]
      @content = @cart.copies
      @price = 3.5 * @content.count
      if @cart.copy_ids != []
        @order = Order.create!(user: @cart.user, number_week: @cart.number_week, price: @price)
        @order.copy_ids = @cart.copy_ids
        @order.copies.each do |copy|
          copy.rented = true
          @order.renting << true
          @order.save
          copy.save
        end
        @cart.number_week = []
        @cart.save
        Cart.where(user_id: current_user.id)[0].copy_ids = []
        UserMailer.client_order(@order, current_user).deliver_now!
        @order.copies.each do |copy|
          UserMailer.proprio_order(copy, current_user).deliver_now!
        end
        UserMailer.admin_order(@order).deliver_now!

      else
        redirect_to '/cart'
        flash[:alert] = 'Vous devez avoir des éléments dans votre panier pour commander'
      end
    end
  end
end
