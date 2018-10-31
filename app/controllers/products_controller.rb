class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  def index
    @products = Product.where(seller_id: current_user.seller)
  end

  def show    
  end

  def new
    @categories = Category.all
    @product = Product.new
  end

  def edit
  end

  def create 
    seller = current_user.seller
    @product = seller.products.new(product_params)
    if @product.save
      flash[:notice] = 'Product successfully added.'
      redirect_to seller_products_path
    else
      flash[:notice] = 'Try again!!!'
      render 'new'
    end
  end

  def update
  end

  def destroy    
    if @product.destroy
      flash[:notice] = 'Product successfully removed.'
      redirect_to seller_products_path
    else
      flash[:notice] = 'Product not removed!!! Try Again'
      redirect_to seller_products_path 
    end
  end

  private
    def set_product 
      @product = Product.find(params[:id])
    end
    
    def product_params
      params.require(:product).permit(:product_name, :about, :price, :quantity, :category_id)
    end
end
