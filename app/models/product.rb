class Product < ApplicationRecord
  #relationships
  belongs_to :seller
  belongs_to :category
  #validation
  validates :product_name, :price, :quantity, presence: true
  validates :price, numericality: true
  validates :quantity, numericality: { only_integer: true }
end
