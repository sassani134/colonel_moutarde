# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :copies
end
