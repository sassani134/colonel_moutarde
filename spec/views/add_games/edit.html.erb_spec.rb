# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'add_games/edit', type: :view do
  before(:each) do
    @add_game = assign(:add_game, AddGame.create!)
  end

  it 'renders the edit add_game form' do
    render

    assert_select 'form[action=?][method=?]', add_game_path(@add_game), 'post' do
    end
  end
end
