class HomeController < ApplicationController
  def index
  end

  def contact
  end

  def explore
  end

  def listing
    @copies = Copy.all
  end
end
