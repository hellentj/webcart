class Seller < ApplicationRecord
  #enum
  enum status: [:pending, :approved]

  #relationships
  belongs_to :user
  has_many :products, dependent: :destroy
  
  #validations
  validates :sname, presence: true,  format: { with: /\A[a-z]+\z/i }  
  validates :website, presence: true
end
