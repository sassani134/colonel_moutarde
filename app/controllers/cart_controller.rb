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
      @content = @cart.items
      @price = 0
      @content.each_with_index do |content, index| 
        @price += content.price * @cart.quantities[index].to_i
      end
      @price
    else
    end
  end

  def create
    if user_signed_in?
      @cart = Cart.where(:user_id => current_user.id)[0]
      unless @cart.item_ids.include?(params[:id_add].to_i)
        @new_cart = @cart.item_ids << params[:id_add].to_i
        Cart.where(:user_id => current_user.id)[0].item_ids = @new_cart
        @new_cart = Cart.where(:user_id => current_user.id)[0].item_ids
        @order = @new_cart.index(params[:id_add].to_i)
        @cart.quantities.insert(@order, 1)
        @cart.save
        redirect_to "/product"
        flash[:success] = "You successfully added the product to your cart"
      else
        @quant = @cart.quantities[@cart.item_ids.index(params[:id_add].to_i)].to_i
        @quant += 1
        @cart.quantities[@cart.item_ids.index(params[:id_add].to_i)] = @quant.to_s
        @cart.save
        redirect_to "/product" 
        flash[:alert] = "You successfully added the product to your cart"
      end
    else
      redirect_to "/product" 
      flash[:alert] = "You must be connected to have a cart"
    end
  end

  def update
    @cart = Cart.find(params[:id])
    @array = @cart.item_ids
    @ind = @cart.item_ids.index(params[:id_modify].to_i)
    if params[:increase] == "true"
      @cart.quantities[@ind] = @cart.quantities[@ind].to_i + 1
      @cart.save
    else
      @cart.quantities[@ind] = @cart.quantities[@ind].to_i - 1
      if @cart.quantities[@ind] == 0
        @cart.quantities[@ind] = @cart.quantities[@ind].to_i + 1
        @cart.save
      else
        @cart.save
      end
    end
    @content = @cart.items
    @price = 0
    @content.each_with_index do |content, index| 
      @price += content.price * @cart.quantities[index].to_i
    end
    @price
  end

  def destroy
    @cart = Cart.find(params[:id])
    @array = @cart.item_ids
    @ind = @cart.item_ids.index(params[:id_delete].to_i)
    @array.delete(params[:id_delete].to_i)
    @cart.quantities.delete_at(@ind)
    @cart.save
    @cart.item_ids = @array
    @content = @cart.items
    @price = 0
    @content.each_with_index do |content, index| 
      @price += content.price * @cart.quantities[index].to_i
    end
    @price
  end
  
  def checkout
    if user_signed_in?
      @cart = Cart.where(:user_id => current_user.id)[0]
      @content = @cart.items
      @price = 0
      @content.each_with_index do |content, index| 
        @price += content.price * @cart.quantities[index].to_i
      end
      if @cart.quantities != []
        @order = Order.create!(user: @cart.user, quantities: @cart.quantities, price: @price)
        @order.item_ids = @cart.item_ids
        @cart.quantities = []
        @cart.save
        Cart.where(:user_id => current_user.id)[0].item_ids = []
        redirect_to "/product"
        flash[:success] = "Vous avez réussi à passer votre commande. Retrouvez là dans votre onglet commande :)"
      else
        redirect_to "/cart"
        flash[:alert] = "Vous devez avoir des éléments dans votre panier pour commander"
      end
    end
  end

  def empty
    Cart.where(:user_id => current_user.id)[0].item_ids = []
    @cart = Cart.where(:user_id => current_user.id)[0]
    @cart.quantities = []
    @cart.save
    redirect_to "/product"
    flash[:success] = "Votre panier a été vidé, retrouvez maintenant d'autres photos qui pourraient vous plaire"
  end 
end
