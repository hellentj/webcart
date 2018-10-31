class Order < ApplicationRecord
  #relationships
  belongs_to :payment
  belongs_to :address
  belongs_to :customer
end
