class User < ApplicationRecord
  has_many :carts
  has_many :views

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  
  has_secure_password



end
