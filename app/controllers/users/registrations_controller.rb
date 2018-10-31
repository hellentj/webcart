class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :password, :password_confirmation, :role))
    if @user.save
      redirect_to welcome_home_index_path
      flash[:notice] = "Please check your mail and confirm"
    else
      params[:role] = @user.role
      render 'new'
    end
  end

  def edit
    super
  end 

  def update
    super
  end

  def destroy
    @user = User.find(params[:user])
    if @user.destroy
      flash[:error] = "Account is deleted"
    else
      flash[:error] = "Couldn't delete account, Please Try Again"
    end
    if current_user.admin?
      redirect_to admin_path(current_user)
    else
      redirect_to root_path
    end
  end
end
