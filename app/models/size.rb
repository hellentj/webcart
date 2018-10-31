class Size < ApplicationRecord
  #relatioships
  has_many :quantities, dependent: :destroy
end
