class Seller < ApplicationRecord
  #relationships
  belongs_to :user
  has_many :products, dependent: :destroy
  #validations
  validates :sname, :website, presence: true
end
