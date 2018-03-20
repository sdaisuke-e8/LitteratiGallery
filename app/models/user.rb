class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true

  has_many :posts
  has_many :favorites
  has_many :favorite_posts, through: :favorites, source: 'post'

  has_secure_password
end
