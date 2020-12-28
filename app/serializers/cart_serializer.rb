class CartSerializer < ActiveModel::Serializer
  attributes :id, :checked_out, :user, :cart_items, :products

  belongs_to :user
  has_many :cart_items
  has_many :products, through: :cart_items
end
