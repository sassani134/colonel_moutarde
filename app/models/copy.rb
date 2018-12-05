class Copy < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_and_belongs_to_many :orders
  has_and_belongs_to_many :carts
end