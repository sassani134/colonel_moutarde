class AdminController < ApplicationController
  def index
    if current_user.admin?
      @orders=order.all
      @renting_copies = Copy.where(:rented => true)
      @overdue_copies = Copy.where(:return => Time.now..DateTime::Infinity.new)
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
      @user = User.find(param[:id])
    else
      redirect_to root_path
    end
  end
end
