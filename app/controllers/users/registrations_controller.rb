class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :password, :password_confirmation, :role))
    if @user.save
      redirect_to  new_user_registration_path
      flash[:notice] = "Please check your mail and confirm"
    else
      render 'new'
    end  	
  end
end
