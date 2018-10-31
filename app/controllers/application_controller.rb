class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  before_action :blocked?
  before_action :my_cart

  def blocked?
    if current_user.present? && current_user.block?
      sign_out current_user
      flash[:error] = "This account has been suspended...."
      redirect_to root_path
    end
  end

  def my_cart
    if user_signed_in?    
      @mycart = current_user.customer.carts.where(check_out:false).count if current_user.customer
    end
  end

  private

  def user_not_authorized(exception)
    flash[error] = "You are not you are not authorized to access this page"
    unless current_user.seller?
      redirect_to root_path
    else
      redirect_to sellers_path
    end
  end
end