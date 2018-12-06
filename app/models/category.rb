class Category < ApplicationRecord
  belongs_to :age
  belongs_to :game
  belongs_to :genre
  belongs_to :number_player
  belongs_to :style
  
end
