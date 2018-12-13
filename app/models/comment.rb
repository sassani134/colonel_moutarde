class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :game
  validates :content, :length => { :minimum => 5 }
end
