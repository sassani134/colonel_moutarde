class Game < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :copies
  has_one_attached :image
end
