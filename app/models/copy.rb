class Copy < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_and_belongs_to_many :order
  has_and_belongs_to_many :cart
end