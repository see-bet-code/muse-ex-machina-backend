class Product < ApplicationRecord
  has_many :cart_items
  has_many :views
  
end
