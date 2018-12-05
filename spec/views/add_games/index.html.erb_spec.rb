require 'rails_helper'

RSpec.describe "add_games/index", type: :view do
  before(:each) do
    assign(:add_games, [
      AddGame.create!(),
      AddGame.create!()
    ])
  end

  it "renders a list of add_games" do
    render
  end
end
