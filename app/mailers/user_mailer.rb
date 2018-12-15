# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Bienvenue sur Colonel Moutarde')
  end

  def client_order(order, loueur)
    @order = order
    @user = loueur
    mail(to: @user.email, subject: 'Demande de location envoyée')
  end

  def proprio_order(copy, loueur)
    @copy = copy
    @loueur = loueur
    mail(to: @copy.user.email, subject: 'Location à confirmer')
  end

  def client_receive(user, copy, weeks)
    @copy = copy
    @user = user
    @weeks = weeks
    mail(to: @user.email, subject: 'Location du jeu confirmée')
  end

  def admin_order(order)
    @order = order
    @users = User.where(role: 'admin')
    @users.each do |user|
      mail(to: user.email, subject: 'Nouvelle commande sur le site')
    end
  end

  def admin_game(game)
    @new_game = game
    @users = User.where(role: 'admin')
    @users.each do |user|
      mail(to: user.email, subject: 'Nouveau jeu à confirmer')
    end
  end
end
