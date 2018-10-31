class Quantity < ApplicationRecord
  belongs_to :size
  belongs_to :product
  belongs_to :colour
  has_many :carts
  #validations
  validates :quantity, presence: true
  #scopes
  scope :find_product_quantity, ->(colour, size, product) {where("colour_id = ? and size_id = ? and product_id = ?", colour, size, product).first}	
end
