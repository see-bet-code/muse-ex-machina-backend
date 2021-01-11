class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :user, :product, :description, :rating

  belongs_to :user
  belongs_to :product
end
