class Colour < ApplicationRecord
  #validations
  validates :colour, presence: true, on: :update
  #relationship
  has_many :images, dependent: :destroy
  has_many :quantities, dependent: :destroy
end
