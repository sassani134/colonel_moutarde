# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @copies = Copy.all
    @users = User.all
  end

  def contact; end

  def explore
    @search = params[:caviarSearch]

    @result = Game.where('title ilike ?', "%#{@search}%")
  end

  def listing
    @games = Game.all
    @categories = Category.all
  end
end
