class User < ApplicationRecord
  #enum
  enum role: [:admin, :seller, :customer]
  enum status: [:unblock, :block]

  #devise_gem
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable
         
  #relationships
  has_one :customer, dependent: :destroy
  has_one :seller, dependent: :destroy
end
