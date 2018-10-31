class Address < ApplicationRecord
  #relationships
  belongs_to :customer
  has_many :orders

  #validations
  validates :address, presence: true
  validates :city, :district, :pincode, presence: true
  validates :pincode, format: { with: /\(?[0-9]{6}\)?/ ,message: "should be 123456"}
end