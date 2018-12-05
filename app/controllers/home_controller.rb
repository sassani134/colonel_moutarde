class HomeController < ApplicationController
  def index
  end

  def contact
  end

  def explore
  end

  def listing
    @games = Game.all
    @categories = Category.all
  end
end
