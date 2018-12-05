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
      @content = @cart.copies
      @price = 3.5 * @content.count
    else
    end
  end

  def destroy
    @cart = Cart.find(params[:id])
    @array = @cart.copy_ids
    @ind = @cart.copy_ids.index(params[:id_delete].to_i)
    @array.delete(params[:id_delete].to_i)
    @cart.copy_ids = @array
    @content = @cart.copies
    @price = 3.5 * @content.count
  
  end
  
  def checkout
    if user_signed_in?
      @cart = Cart.where(:user_id => current_user.id)[0]
      @content = @cart.copies
      @price = 3.5 * @content.count
      if @cart.copy_ids != []
        @order = Order.create!(user: @cart.user, price: @price)
        @order.copy_ids = @cart.copy_ids
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
    Cart.where(:user_id => current_user.id)[0].copy_ids = []
    redirect_to "/product"
    flash[:success] = "Votre panier a été vidé, retrouvez maintenant d'autres jeux qui pourraient vous plaire"
  end 

end
