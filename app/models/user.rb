class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :copies
  has_many :orders
  has_one :cart
  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  after_create :welcome_email

  def welcome_email
    #UserMailer.welcome_email(self).deliver_now!
  end
  

  def set_default_role
    self.role ||= :user
  end


end
