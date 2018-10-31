class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  def index
    @customers = Customer.all
  end

  def show
  end

  def new
    @customer = current_user.create_customer
  end

  def edit
  end


  def create
    @customer = current_user.create_customer(customer_params)
    if @customer.save
      flash[:notice] = 'Profile successfully added.'
      redirect_to @customer
    else
      flash[:notice] = 'Try again!!!'
      render 'new'
    end
  end

  def update
    if @customer.update(customer_params)
      flash[:notice] = 'Profile successfully updated.'
      redirect_to @customer
    else
      flash[:notice] = 'Try again!!!'
      redirect_to edit_customer_path
    end  
  end

  def destroy
    @customer.destroy
  end

  private
   
    def set_customer
      @customer = current_user.customer
    end

    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :phone, :city, :gender, :DOB)
    end
end
