class Product < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :reviews
  
end
