class Customer < ApplicationRecord
  #relationships
  belongs_to :user
  has_many :carts, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  #validation
  validates :first_name, :last_name, :phone, presence: true
  validates :first_name, :last_name, :phone, presence: true, on: :update
  validates :phone, format: { with: /\(?[0-9]{10}\)?/, message: "Phone numbers must be 10 digits"}
end
