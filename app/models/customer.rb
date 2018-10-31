class Customer < ApplicationRecord
  #relationships
  belongs_to :user
  #validation
  validates :first_name, :last_name, :phone, presence: true, on: :update
  validates :phone, numericality:  { only_integer: true }
end
