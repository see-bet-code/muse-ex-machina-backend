class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :age, :username, :password, :avatar, :carts, :views
  has_many :carts
  has_many :views

  def avatar
    rails_blob_path(object.avatar, only_path: true) if object.avatar.attached?
  end

  # def carts
  #   object.carts.map do |cart|
  #     CartSerializer.new(attendee, scope: scope, root: false, event: object)
  #   end
  # end

end