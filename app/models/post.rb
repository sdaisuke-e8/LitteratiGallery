class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :user_id, presence: true
  validates :description, {presence: true, length: {maximum: 140}}
  validates :image, presence: true

  belongs_to :user
  has_many :favorites
  has_many :comments
end
