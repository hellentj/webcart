class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  add_breadcrumb "Home", :sellers_path

  def index
    add_breadcrumb "Products", seller_products_path(current_user.seller)
    @seller = current_user.seller
    @products = @seller.products.paginate(page: params[:page], per_page: 20)
  end

  def new
    add_breadcrumb "New Product", new_seller_product_path(current_user.seller)
    @product = Product.new
    @categories = Category.all
    @sizes = Size.all
  end

  def show 
    @product = Product.find(params[:id])
    @images = @product.images
    add_breadcrumb @product.product_name, seller_product_path(current_user.seller)
  end

  def edit
  end

  def create 
    seller = current_user.seller
    @product = seller.products.new(product_params)
    if @product.save
      flash[:success] = 'Product successfully added.'
      redirect_to new_quantity_path(product: @product)
    else
      flash[:error] = 'Something went wrong!! Please Try again!!!'
      @categories = Category.all
      render 'new'
    end
  end

  def update
  end

  def destroy
    if @product.destroy
      flash[:error] = 'Product successfully removed.'
    else
      flash[:error] = 'Product not removed!!! Try Again'
    end
    redirect_to seller_products_path
  end

  private
    def set_product 
      @product = Product.find(params[:id])
    end
    
    def product_params
      params.require(:product).permit(:product_name, :about, :price, :quantity, :category_id)
    end
end