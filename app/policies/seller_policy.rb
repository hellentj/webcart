class SellerPolicy < ApplicationPolicy
  def show?
    user.seller == record
  end
end