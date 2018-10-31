class AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Address", :addresses_path, :only => %w(index new)

  def index
    @customer = current_user.customer
    @addresses = @customer.addresses
  end

  def show
    add_breadcrumb "cart", customer_carts_path(current_user.customer)
    add_breadcrumb "Select Address", address_path(current_user.customer)
    @customer = Customer.find(params[:id])
    @addresses = @customer.addresses
    authorize @customer
  end

  def new
    add_breadcrumb "New Address", new_address_path
    @address = Address.new
    params[:path] ? @path = "order" : @path = "address"
  end

  def edit
  end

  def create
    customer = current_user.customer
    @address = customer.addresses.new(address_params)
    @path = params[:address][:path]
    if @address.save
      flash[:success] = "Address successfully added"
      if @path == "order"
        redirect_to  address_path(current_user.customer)
      else
        redirect_to addresses_path
      end
    else
      flash[:error] = "Please Try Again to add address"
      render 'new'
    end
  end

  def update
    if @address.update(address_params)
      flash[:notice] = "Address has been updated"
      redirect_to addresses_path
    else
      flash[:error] = "Couldn't update address, Please Try Again"
      render 'edit'
    end
  end

  def destroy
    @count = 1
    @address.customer.orders.each do |order|
      if order.address == @address
        @count += 1
      end
    end
    if @count == 1 
      if @address.destroy
        flash[:error] = "Address has been deleted"
      else
        flash[:error] = "Couldn't delete address, Please Try Again"
      end
    else
      flash[:error] = "This address is being used for order, So you can't delete it..."
    end
    redirect_to addresses_path
  end

  private
    
    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(:address, :city, :district, :state, :country, :pincode)
    end
end