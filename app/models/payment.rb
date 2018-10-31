class Payment < ApplicationRecord
  #relationships
  has_many :orders
end
