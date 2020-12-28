class ProductSerializer < ActiveModel::Serializer
  attributes :id, :price, :description, :category, :title, :image, :asin, :merchant_name, :created_at, :updated_at
end
