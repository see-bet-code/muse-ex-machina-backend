class User < ApplicationRecord
  has_many :carts
  has_many :views
  has_one_attached :avatar
  before_create :default_avatar

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  
  has_secure_password

  private

    def default_avatar
      self.avatar.attach(
        io: File.open('app/assets/iphone-emoji-love-like-transparent-face-heart-emoji.png'),
        filename: 'iphone-emoji-love-like-transparent-face-heart-emoji.png') unless self.avatar.attached?
    end

end
