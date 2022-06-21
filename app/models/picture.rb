class Picture < ApplicationRecord
  validates :image, presence: true
  validates :content, presence: true
  belongs_to :user
  mount_uploader :image, ImageUploader
end
