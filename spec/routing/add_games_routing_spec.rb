require "rails_helper"

RSpec.describe AddGamesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/add_games").to route_to("add_games#index")
    end

    it "routes to #new" do
      expect(:get => "/add_games/new").to route_to("add_games#new")
    end

    it "routes to #show" do
      expect(:get => "/add_games/1").to route_to("add_games#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/add_games/1/edit").to route_to("add_games#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/add_games").to route_to("add_games#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/add_games/1").to route_to("add_games#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/add_games/1").to route_to("add_games#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/add_games/1").to route_to("add_games#destroy", :id => "1")
    end
  end
end
