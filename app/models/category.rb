class Category < ApplicationRecord
  belongs_to :age
  belongs_to :game
  belongs_to :genre
  belongs_to :player_number
  belongs_to :style
end
