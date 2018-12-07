require 'rails_helper'

RSpec.describe "add_games/show", type: :view do
  before(:each) do
    @add_game = assign(:add_game, AddGame.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
