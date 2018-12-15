# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
   def welcome_email 
      @user= User.last
      UserMailer.welcome_email(@user)
   end

   def client_order 
      @user= User.last
      @order = Order.last
      UserMailer.client_order(@order,@user)
   end

   def client_receive
      @game= Game.all
      @copy= Order.last.copies.first
      @number_week = 1
      @user= User.last
      UserMailer.client_receive(@user, @copy, @number_week)
   end

   def proprio_order 
      @user= User.last
      @order = Order.last.copies.last
      UserMailer.proprio_order(@order, @user)
   end


   def admin_order
      User.last.admin!
      @order = Order.last
      @user= User.last
      UserMailer.admin_order(@order)
   end


end
