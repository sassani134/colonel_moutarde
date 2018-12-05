class OrderController < ApplicationController
  
  respond_to? :html, :js
 
  def index
    if user_signed_in?
      @cart=Cart.where(:user_id => current_user.id)[0]
      if @cart
        @cart
      else
        @cart = Cart.create!(user_id: current_user.id)
      end
      @content = @cart.copy_ids
      @price = 3.5 * @content.count
    else
    end
  end

  def destroy
    @cart = Cart.find(params[:id])
    @array = @cart.item_ids
    @ind = @cart.item_ids.index(params[:id_delete].to_i)
    @array.delete(params[:id_delete].to_i)
    @cart.item_ids = @array
    @content = @cart.copy_ids
    @price = 3.5 * @content.count
  
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
    @cart.save
    redirect_to "/product"
    flash[:success] = "Votre panier a été vidé, retrouvez maintenant d'autres photos qui pourraient vous plaire"
  end 
end
end
