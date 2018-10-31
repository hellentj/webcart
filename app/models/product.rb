class Product < ApplicationRecord
  #enum
  enum status: [:unblock, :block]

  #relationships
  belongs_to :seller
  belongs_to :category
  has_many :carts, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :quantities, dependent: :destroy
  has_many :colours, through: :quantities
  has_many :sizes, through: :quantities
  #validation
  validates :product_name, :price, presence: true
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 1000000 }
end
