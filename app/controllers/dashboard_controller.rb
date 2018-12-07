class DashboardController < ApplicationController

  def index
    @rented_copies = current_user.copies.where(:rented => false)
    @renting_copies = current_user.copies.where(:rented => true)
    @unconfirmed_copies = @renting_copies.where(:return => nil)
    @confirmed_copies = @renting_copies.where.not(:return => nil)
    @cart=Cart.where(:user_id => current_user.id)
    @past_orders=current_user.orders
    @active_orders=@past_orders.where("'true' = ANY (renting)")
    @games = Game.all
    @title=[]
    @games.each do |game|
      @title << game.title
    end
  end

  def rent_copy
    @games = Game.all
    @title=[]
    @games.each do |game|
      @title << game.title
    end
  end

  def save_copy
    @address = [params[:anything][:street], params[:anything][:city], params[:anything][:postal_code], params[:anything][:country]].compact.join(', ')
    @game = Game.where(:title => params[:anything][:game])[0]
    @copy = Copy.new(user:current_user, game: @game, address:@address, available: true, return:nil, rented:false)
    if @copy.save
      redirect_to root_path
    else 
      redirect_to "/rent_copy"
    end
  end
  
  def available_copy

  end

  def confirm_copy
    @copy = Copy.find(params[:id])
    if @copy.user == current_user && @copy.rented ==true
      @ind = @copy.order.copy_ids.index(params[:id].to_i)
      @weeks=@copy.order.number_week[@ind]
      @copy.return = (Time.now + @week.week).to_date
      @copy.save
      redirect_to '/dashboard'
    else
      redirect_to root_path
    end
  end

  def return_copy
    @copy = Copy.find(params[:id])
    if @copy.user == current_user && @copy.rented ==true
      @copy.rented = false
      @copy.return = nil
      @copy.save
      redirect_to '/dashboard'
    else
      redirect_to root_path
    end
  end

  def toggle_past
  @order = Order.find(params[:id])
  end
end

