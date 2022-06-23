class Picture < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  validates :image, presence: true
  validates :content, presence: true
  belongs_to :user
  mount_uploader :image, ImageUploader
end
