# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    @user = User.last
    UserMailer.welcome_email(@user)
  end

  def client_order
    @user = User.last
    UserMailer.client_order(@user)
  end

  def client_receive
    @game = Game.all
    @copies = @game.copies
    @proprio = []
    @proprio_mail = []
    @copies.each do |copy|
      @proprio << copy.user.username
      @proprio_mail << copy.user.email
    end
    puts @proprio_mail
    puts @proprio
    puts 'AAAAAAAAAAAAAAA'
    puts 'AAAAAAAAAAAAAAA'
    puts 'AAAAAAAAAAAAAAA'
    puts 'AAAAAAAAAAAAAAA'
    puts 'AAAAAAAAAAAAAAA'
    puts 'AAAAAAAAAAAAAAA'
    @user = User.last
    UserMailer.client_receive(@user, @copies)
  end

  def proprio_order
    @user = User.last
    UserMailer.proprio_order(@user)
  end

  def admin_order
    User.last.admin!
    @user = User.last
    UserMailer.admin_order(@user)
 end
end
