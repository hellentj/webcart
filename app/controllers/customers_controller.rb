class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update]
  add_breadcrumb "Home", :root_path, only: [:new, :edit, :index]
  def index
  end

  def show
    if current_user.admin?
      add_breadcrumb "Home", admins_path
      add_breadcrumb "Profile"
      @customer = Customer.find(params[:id])
    else
      add_breadcrumb "Home", root_path
      add_breadcrumb "Profile", customer_path(current_user.customer)
      @customer = Customer.find(params[:id])
      authorize @customer
    end
  end

  def new
    add_breadcrumb "new", new_customer_path
    @customer = Customer.new
  end

  def edit
    add_breadcrumb "Edit Profile", edit_customer_path(current_user.customer)
    unless current_user.customer
      redirect_to new_customer_path
    end
  end


  def create
    add_breadcrumb "Profile", new_customer_path
    @customer = current_user.create_customer(customer_params)
    if @customer.save
      flash[:success] = 'Profile successfully added.'
      redirect_to customer_path(@customer)
    else
      flash[:error] = 'Something went wrong!! Please Try again!!!'
      render 'new'
    end
  end

  def update
    if @customer.update(customer_params)
      flash[:notice] = 'Profile successfully updated.'
      redirect_to customer_path(current_user.customer)
    else
      flash[:error] = 'Something went wrong!! Please Try again!!!'
      render 'edit'
    end  
  end

  def destroy
    if @customer.destroy
      flash[:error] = 'Your Account has been removed'
    else
      flash[:error] = 'Your Account can not be removed'
    end
  end

  private
   
    def set_customer
      @customer = current_user.customer
    end

    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :phone, :city, :gender, :DOB)
    end
end