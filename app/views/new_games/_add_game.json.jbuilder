# frozen_string_literal: true

json.extract! add_game, :id, :created_at, :updated_at
json.url add_game_url(add_game, format: :json)
