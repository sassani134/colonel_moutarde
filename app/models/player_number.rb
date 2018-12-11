class PlayerNumber < ApplicationRecord
  has_many :categories
  has_many :games, :through => :categories
  def number_total
    "#{number_low} à #{number_high}"
  end
end
