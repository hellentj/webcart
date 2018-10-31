class HomeController < ApplicationController
  add_breadcrumb "Home", :root_path, only: [:show, :after_check_product, :index]
  add_breadcrumb "Product", :home_path, only: [:show, :after_check_product]
  
  def welcome
  end

  def show
    @product = Product.find(params[:id])
    @quantities = @product.quantities 
    @images = @product.images
    @colours = @product.colours.distinct
    @sizes = @product.sizes.distinct
  end

  def after_check_product    
    @quantity = Quantity.find(params[:quantity])
    @product = Product.find(params[:id])
    @images = @product.images.where(colour_id: @quantity.colour_id)
    add_breadcrumb @product.product_name, after_check_product_home_path
  end


  def check_product
    colour = params[:colour_id]
    size = params[:size_id]
    product = params[:product_id]
    @quantity = Quantity.find_product_quantity(colour, size, product)
    begin
      if @quantity.quantity >=1
        flash[:notice] = "product is available"
        redirect_to after_check_product_home_path(product, quantity: @quantity.id)
      else
        flash[:error] = "Product is out of stock"
        redirect_to home_path
      end
    rescue
      flash[:error] = "Sorry!! Product not available, Search for different colours and size"
      redirect_to home_path
    end
  end

  def index
    if user_signed_in?
      unless current_user.seller?
        unless current_user.admin?
          unless current_user.customer
            redirect_to new_customer_path
          end
        end
      end
    end
    category = params[:category]
    unless category
      @products = Product.where("quantity > ? and status = ?", 0, 0).paginate(page: params[:page], per_page: 20)
    else
      @category = Category.find_by(category_name: params[:category])
      @products = @category.products.where("quantity > ? and status = ?", 0, 0).paginate(page: params[:page], per_page: 20)
    end
  end
end