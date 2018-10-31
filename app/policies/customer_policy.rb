class CustomerPolicy < ApplicationPolicy
  def show?
    user.customer == record
  end
end