class QuantitiesController < ApplicationController
  before_action :set_quantity, only: [:show, :edit, :update, :destroy]
  before_action :set_product, only: [:index, :new, :edit]
  before_action :authenticate_user!
  add_breadcrumb "Home", :sellers_path, only: [:new, :index, :edit]

  def index    
    @quantities = @product.quantities
    add_breadcrumb @product.product_name, seller_product_path(current_user.seller, @product)
    add_breadcrumb "quantity", quantities_path
  end


  def show
  end


  def new
    @quantity = Quantity.new
    add_breadcrumb @product.product_name, seller_product_path(current_user.seller, @product)
    add_breadcrumb "New Quantity", new_quantity_path
  end


  def edit
  end


  def create 
    @quantity = Quantity.find_or_create_by(quantity_params)
    @quantity.quantity += (params[:quantity][:quantity]).to_d
    if @quantity.save
      @product = Product.find(@quantity.product.id)
      @product.quantity += @quantity.quantity
      @product.save
      flash[:success] = "Product size and quantity added"
      redirect_to new_image_path(product: @quantity.product_id)
    else
      flash[:error] = "Something went wrong!! Please Try Again"
      @product = @quantity.product
      render 'new'
    end
  end


  def update
    if @quantity.update(quantity_params)
      flash[:notice] = "Quantity has been Updated"
      redirect_to seller_products_path(current_user.seller)
    else
      flash[:error] = "Quantity couldn't update..Try Again"
      render 'edit'
    end
  end


  def destroy
    @product = @quantity.product
    if @quantity.destroy
      flash[:error] = "Quantity has been deleted"
    else
      flash[:error] = "Quantity couldn't delete..Try again"
    end
    redirect_to seller_product_path(current_user.seller, @product)
  end


  private

    def set_quantity
      @quantity = Quantity.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product])
    end
   
    def quantity_params
      params.require(:quantity).permit(:product_id, :size_id, :colour_id)
    end
end