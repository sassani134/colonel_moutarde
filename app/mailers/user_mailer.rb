# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Bienvenue sur Colonel Moutarde')
  end

  def client_order(user)
    @user = user
    mail(to: @user.email, subject: 'Demande de location envoyée')
  end

  def proprio_order(user)
    @user = user
    mail(to: @user.email, subject: 'Location à confirmer')
  end

  def client_receive(user, copy)
    @copies = copy
    @user = user
    mail(to: @user.email, subject: 'Location du jeu confirmée')
  end

  def admin_order(_user)
    @users = User.where(role: 'admin')
    @users.each do |user|
      mail(to: user.email, subject: 'Nouvelle commande sur le site')
    end
   end
end
