# frozen_string_literal: true

class PlayerNumber < ApplicationRecord
  has_many :categories
  has_many :games, through: :categories
  def number_total
    if number_low == number_high
      " à #{number_low}"
    else
      " de #{number_low} à #{number_high}"
    end
  end
end
