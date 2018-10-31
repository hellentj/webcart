class CartsController < ApplicationController
  before_action :set_cart, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "cart", customer_carts_path
    @customer = current_user.customer
    @carts = @customer.carts.where(check_out:false)
    if @carts.empty?
      flash[:notice] = "Cart is Empty!!  Add items to Cart"
      redirect_to home_index_path
    end
    @price = 0
  end


  def new
    @cart = Cart.new
    @product = Product.find(params[:product_id])
    @quantities = @product.quantities
    @colours = Colour.all
  end


  def edit
  end

  def create
    @product = Product.find(params[:product_id])
    customer = params[:customer_id]
    @quantity = Quantity.find(params[:quantity])
    if @quantity.quantity >=1
      @cart = Cart.find_or_create_by(customer_id: customer, product_id: @product.id, price: @product.price,quantity_id: @quantity.id, check_out: false)
      @cart.total_quantity += 1
      if @cart.save
        reduce_quantity(@quantity.id)
        flash[:success] = 'Product is added to cart.'
      else
        flash[:error] = 'Product is not added to cart, Please Try Again'
      end
    else
      flash[:error] = "Sorry!!! Product is out of stock"
    end
    redirect_to root_path
  end

  def update
    cart = Cart.find(params[:id])
    id = @cart.quantity_id 
    @quantity = cart.quantity
    if  params[:item] == "add"
      if @quantity.quantity >=1
        @cart.total_quantity += 1
        if @cart.save
          reduce_quantity(@quantity.id)
          flash[:success] = "Product quantity added"
        end
      else
        flash[:error] = "Product is Out of stock"
      end
    else
      @cart.total_quantity -= 1
      if @cart.save
        add_quantity(id,1)
      else
        flash[:error] = "Please Try Again to change quantity"
      end
    end
    redirect_to customer_carts_path(current_user.customer)
  end

  def destroy
    value = @cart.total_quantity
    id = @cart.quantity_id
    unless @cart.order_id.blank?
      path = "order"
      order = Order.find(@cart.order_id)    
    end
    if @cart.destroy
      add_quantity(id,value)
      unless path == "order"
        flash[:error] = "Your item is removed from the cart"
        redirect_to customer_carts_path(current_user.customer)
      else
        order_check(order)
        flash[:error] = "Your order is cancelled"
        redirect_to order_path(current_user)
      end
    else
      flash[:error] = "Something went wrong!! Please Try Again"
      redirect_to root_path
    end
  end

  private

    def reduce_quantity(id)
      @quantity = Quantity.find(id)
      @quantity.quantity -= 1
      @quantity.save
      @product = Product.find(@quantity.product.id)
      @product.quantity -= 1
      @product.save
    end

    def add_quantity(id,value)
      @quantity = Quantity.find(id)
      @quantity.quantity += value
      @quantity.save
      @product = Product.find(@quantity.product.id)
      @product.quantity += value
      @product.save
    end

    def set_cart
      @cart = Cart.find(params[:id])
    end

    def order_check(order)
      @carts = Cart.where(order_id: order)
      if @carts.blank?
        order.destroy
      end
    end
end