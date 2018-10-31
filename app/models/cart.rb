class Cart < ApplicationRecord
  #relationships
  belongs_to :customer
  belongs_to :product
  belongs_to :quantity

  #scope
  scope :check_out_cart, -> {where(check_out:true)}
end
