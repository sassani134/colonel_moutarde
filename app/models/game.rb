class Game < ApplicationRecord
  has_many :categories
  has_many :ages, :through => :categories
  has_many :player_numbers, :through => :categories
  has_many :styles, :through => :categories
  has_many :genres, :through => :categories
  has_many :copies
  has_one_attached :image
  has_many :comments
end
