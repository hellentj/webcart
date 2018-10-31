class Category < ApplicationRecord
  #relationships
  has_many :products, dependent: :destroy
  
  #validations
  validates :category_name, presence: true
  validates_each :category_name do |record, attr, value|
    record.errors.add(attr, 'must start with upper case') if value =~ /\A[[:lower:]]/
  end
end
