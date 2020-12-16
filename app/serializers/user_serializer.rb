class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :username, :password, :balance
end
