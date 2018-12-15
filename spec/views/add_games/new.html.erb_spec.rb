# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'add_games/new', type: :view do
  before(:each) do
    assign(:add_game, AddGame.new)
  end

  it 'renders new add_game form' do
    render

    assert_select 'form[action=?][method=?]', add_games_path, 'post' do
    end
  end
end
