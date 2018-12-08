require 'rails_helper'

RSpec.describe "AddGames", type: :request do
  describe "GET /add_games" do
    it "works! (now write some real specs)" do
      get add_games_path
      expect(response).to have_http_status(200)
    end
  end
end
