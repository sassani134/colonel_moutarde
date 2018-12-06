class Age < ApplicationRecord
  has_many :categories
  has_many :games, :through => :categories
end
