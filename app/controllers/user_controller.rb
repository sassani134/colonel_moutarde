class UserController < ApplicationController
  def index
    @copies = current_user.copies
  end

  def add_game
    @games = Game.all
    @title=[]
    @games.each do |game|
      @title << game.title
    end
  end

  def save_game
  end
end

