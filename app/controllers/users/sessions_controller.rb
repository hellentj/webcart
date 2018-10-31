class Users::SessionsController < Devise::SessionsController
  
  def new
    super
  end

  def create
    if user_signed_in?
      if current_user.present? && current_user.unblock?
        if current_user.admin?
          redirect_to admins_path
        elsif current_user.seller?
          redirect_to sellers_path
        else
          redirect_to welcome_home_index_path
        end
        flash[:success] = "successfully signed in"
      else
        sign_out current_user
        flash[:error] = "This account has been suspended...."
        redirect_to root_path
      end
    else
      flash[:error] = "Invalid Username or Password"
      redirect_to new_user_session_path
    end
  end
end