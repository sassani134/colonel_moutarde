# frozen_string_literal: true

class Genre < ApplicationRecord
  has_many :categories
  has_many :games, through: :categories
end
