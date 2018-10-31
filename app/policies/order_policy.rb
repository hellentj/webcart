class OrderPolicy < ApplicationPolicy
  def order_details?
  	record.customer.user == user
  end
end