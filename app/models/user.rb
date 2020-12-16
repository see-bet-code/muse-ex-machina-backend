class User < ApplicationRecord
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :age, numericality: { greater_than_or_equal_to: 18 }
  has_secure_password



end
