class Category < ApplicationRecord
  #relationships
  has_many :products, dependent: :destroy
  #validations
  validates :category_name, presence: true
end
