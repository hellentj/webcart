class Users::SessionsController < Devise::SessionsController
  
  def new
    super
  end

  def create
    if user_signed_in?
      if current_user.customer?
        redirect_to home_index_path
      else
        redirect_to sellers_path
      end
    else
      flash[:notice] = "Invalid Username or Password"
      redirect_to root_path
    end
  end


end
