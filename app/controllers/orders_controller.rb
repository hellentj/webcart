class OrdersController < ApplicationController
  before_action :authenticate_user!
  add_breadcrumb "Home", :root_path, only: [:show, :new, :index, :order_details]
  add_breadcrumb "orders", :order_path, only: [:order_details, :show]

  def order_details
    add_breadcrumb "Order", order_details_order_path
    @order = Order.find(params[:order])
    @carts = Cart.where(order_id:@order)
    authorize @order
  end

  def show
    @customer = current_user.customer
    @orders = @customer.orders.paginate(page: params[:page], per_page: 9)
    @carts = @customer.carts.check_out_cart
  end 

  def new
    add_breadcrumb "cart", customer_carts_path(current_user.customer)
    add_breadcrumb "Select Address", address_path(current_user.customer)
    add_breadcrumb "order", new_order_path
    @order = Order.new
    @address = Address.find(params[:address])
  end

  def edit
  end

  def create
    @customer = current_user.customer
    @order = @customer.orders.new(order_params)
    if @order.save!
      product_check(@customer)
      @cart = @customer.carts
      @cart.where(check_out: false).each do |cart|
        cart.update(order_id: @order.id)
        cart.update(check_out: true)
        @product = cart.product
        @product.sold += cart.total_quantity.to_d
        @product.save
        UserMailer.with(user: @product.seller).delivery_request.deliver_now
      end
      UserMailer.with(user: @customer).order_details.deliver_now
      flash[:notice] = "You are done with Order.
      The product will be delivered within mentioned date.
      THANK YOU FOR THE PURCHASE"
      redirect_to root_path
    else
      flash[:error] = "Sorry!!! Something went wrong! Please Try Again"
      redirect_to customer_carts_path(current_user.customer)
    end
  end


  def update
  end

  def destroy
    @order.destroy
  end

  private
    def product_check(customer)
      @cart = customer.carts
      @cart.each do |cart|
        if cart.product.seller.user.block?
          cart.destroy
        end
      end
    end

    def order_params
      params.require(:order).permit(:address_id, :payment_id, :cart_id)
    end
end