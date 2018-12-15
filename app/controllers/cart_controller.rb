# frozen_string_literal: true

class CartController < ApplicationController
  respond_to? :html, :js

  def index
    if user_signed_in?
      @cart = Cart.where(user_id: current_user.id)[0]
      @cart || @cart = Cart.create!(user_id: current_user.id)

      @price = 0
      @cart.copy_ids.each_with_index do |_content, index|
        @price += 3.5 * @cart.number_week[index]
      end
      @price
    end
  end

  def create
    if user_signed_in?
      @cart = Cart.where(user_id: current_user.id)[0]
      if @cart.copy_ids.include?(params[:id_add].to_i)
        @quant = @cart.number_week[@cart.copy_ids.index(params[:id_add].to_i)].to_i
        @quant += 1
        @cart.number_week[@cart.copy_ids.index(params[:id_add].to_i)] = @quant.to_s
        @cart.save
        redirect_to '/dashboard'
        flash[:alert] = 'Votre jeu a bien été ajouté à votre panier !'
      else
        @new_cart = @cart.copy_ids << params[:id_add].to_i
        Cart.where(user_id: current_user.id)[0].copy_ids = @new_cart
        @new_cart = Cart.where(user_id: current_user.id)[0].copy_ids
        @order = @new_cart.index(params[:id_add].to_i)
        @cart.number_week.insert(@order, 1)
        @cart.save
        redirect_to '/dashboard'
        flash[:success] = 'Votre jeu a bien été ajouté à votre panier !'
      end
    else
      redirect_to '/listing'
      flash[:alert] = 'Vous devez être connecté pour accéder au panier'
    end
  end

  def update
    @cart = Cart.find(params[:id])
    @array = @cart.copy_ids
    @ind = @cart.copy_ids.index(params[:id_modify].to_i)
    if params[:increase] == 'true'
      @cart.number_week[@ind] = @cart.number_week[@ind] + 1
      @cart.save
    else
      @cart.number_week[@ind] = @cart.number_week[@ind] - 1
      if @cart.number_week[@ind] == 0
        @cart.number_week[@ind] = @cart.number_week[@ind] + 1
        @cart.save
      else
        @cart.save
      end
    end
    @price = 0
    @cart.copy_ids.each_with_index do |_content, index|
      @price += 3.5 * @cart.number_week[index]
    end
    @price
  end

  def destroy
    if user_signed_in?
      @cart = Cart.find(params[:id])
      @array = @cart.copy_ids
      @ind = @cart.copy_ids.index(params[:id_delete].to_i)
      @array.delete(params[:id_delete].to_i)
      @cart.number_week.delete_at(@ind)
      @cart.save
      @cart.copy_ids = @array
      @content = @cart.copies
      @price = 0
      @price = 0
      @cart.copy_ids.each_with_index do |_content, index|
        @price += 3.5 * @cart.number_week[index]
      end
      @price
    end
  end

  def empty
    @cart = Cart.where(user_id: current_user.id)[0]
    @cart.number_week = []
    @cart.save
    Cart.where(user_id: current_user.id)[0].copy_ids = []
    redirect_to '/listing'
    flash[:success] = "Votre panier a été vidé, retrouvez maintenant d'autres jeux qui pourraient vous plaire"
  end
end
