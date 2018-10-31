class Image < ApplicationRecord
  mount_uploader :image, ImageUploader
  #relationships
  belongs_to :product
  belongs_to :colour
  #validations
  validates :image ,presence:  {message: "Must select"}
end
