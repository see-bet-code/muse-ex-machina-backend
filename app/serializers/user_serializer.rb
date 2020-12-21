class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :username, :password, :views, :carts
end
