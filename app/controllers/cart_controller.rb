class CartController < ApplicationController
  
  respond_to? :html, :js
 
  def index
    if user_signed_in?
      @cart=Cart.where(:user_id => current_user.id)[0]
      if @cart
        @cart
      else
        @cart = Cart.create!(user_id: current_user.id)
      end
      
      @price = 0
      @cart.copy_ids.each_with_index do |content, index| 
        @price += 3.5 * @cart.number_week[index]
      end
      @price
    else
    end
  end

  def create
    if user_signed_in?
      @cart = Cart.where(:user_id => current_user.id)[0]
      unless @cart.copy_ids.include?(params[:id_add].to_i)
        @new_cart = @cart.copy_ids << params[:id_add].to_i
        Cart.where(:user_id => current_user.id)[0].copy_ids = @new_cart
        @new_cart = Cart.where(:user_id => current_user.id)[0].copy_ids
        @order = @new_cart.index(params[:id_add].to_i)
        @cart.number_week.insert(@order, 1)
        @cart.save
        redirect_to "/listing"
        flash[:success] = "You successfully added the product to your cart"
      else
        @quant = @cart.number_week[@cart.copy_ids.index(params[:id_add].to_i)].to_i
        @quant += 1
        @cart.number_week[@cart.copy_ids.index(params[:id_add].to_i)] = @quant.to_s
        @cart.save
        redirect_to "/listing" 
        flash[:alert] = "You successfully added the product to your cart"
      end
    else
      redirect_to "/listing" 
      flash[:alert] = "You must be connected to have a cart"
    end
  end

  def update
    @cart = Cart.find(params[:id])
    @array = @cart.copy_ids
    @ind = @cart.copy_ids.index(params[:id_modify].to_i)
    if params[:increase] == "true"
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
    @cart.copy_ids.each_with_index do |content, index| 
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
      @content = @cart.copys
      @price = 0
      @content.each_with_index do |content, index| 
        @price += content.price * @cart.number_week[index]
      end
      @price
    end
  end
  
  def checkout
    if user_signed_in?
      @cart = Cart.where(:user_id => current_user.id)[0]
      @content = @cart.copies
      @price = 3.5 * @content.count
      if @cart.copy_ids != []
        @order = Order.create!(user: @cart.user, number_week: @cart.number_week, price: @price)
        @order.copy_ids = @cart.copy_ids
        @order.renting = Array.new(@cart.copy_ids.count, true)
        @order.copies.each do |copy|
          copy.rented=true
          copy.save
        end
        @cart.number_week = []
        @cart.save
        UserMailer.client_order(current_user).deliver_now!
        UserMailer.proprio_order(current_user).deliver_now!
        UserMailer.admin_order.deliver_now!
        Cart.where(:user_id => current_user.id)[0].copy_ids = []
        redirect_to "/"
        flash[:success] = "Vous avez réussi à passer votre commande. Retrouvez là dans votre onglet commande :)"
      else
        redirect_to "/cart"
        flash[:alert] = "Vous devez avoir des éléments dans votre panier pour commander"
      end
    end
  end

  def empty
    @cart.number_week = []
    @cart.save
    Cart.where(:user_id => current_user.id)[0].copy_ids = []
    redirect_to "/listing"
    flash[:success] = "Votre panier a été vidé, retrouvez maintenant d'autres jeux qui pourraient vous plaire"
  end 

end
