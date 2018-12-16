# frozen_string_literal: true

class AdminController < ApplicationController
  def index
    if current_user.admin?
      @orders = Order.all
      @renting_copies = Copy.where(rented: true)
      @overdue_copies = Copy.where(Copy.arel_table[:return].lt(Time.now))
      @games = Game.where(confirm: false)
    else
      redirect_to root_path
    end
  end

  def users
    if current_user.admin?
      @users = User.all
    else
      redirect_to root_path
    end
  end

  def show
    if current_user.admin?
      @user = User.find(params[:id])
      @past_orders = @user.orders
      @active_orders = @past_orders.where("'true' = ANY (renting)")
    else
      redirect_to root_path
    end
  end
end
