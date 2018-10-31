class ImagesController < ApplicationController
  before_action :set_image, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  add_breadcrumb "Home", :sellers_path, only: [:new, :index]

  def index
    @product = Product.find(params[:product])
    @images = @product.images
    add_breadcrumb @product.product_name, seller_product_path(current_user.seller, @product)
    add_breadcrumb "Images", images_path
  end

 

  def new
    @product = Product.find(params[:product])
    unless @product.quantities.blank?
      @image = Image.new
    else
      flash[:error] = "You should add quantity"
      redirect_to  new_quantity_path(product: @product)
    end
    add_breadcrumb @product.product_name, seller_product_path(current_user.seller, @product)
    add_breadcrumb "New Image", new_image_path
  end

  def edit
  end


  def create
    @image = Image.new(image_params)
    if @image.save
      flash[:success] = 'Image successfully added.'
      redirect_to seller_product_path(current_user.seller, @image.product)
    else
      flash[:error] = 'Something went wrong!! Please Try again!!!'
      @product = @image.product
      render 'new'
    end
  end

  def update
    if @image.update(image_params)
      flash[:notice] = 'Image successfully updated.'
      redirect_to @image
    else
      flash[:error] = 'Something went wrong!! Please Try again!!!'
      render 'edit'
    end
  end

  def destroy
    product = @image.product
    if @image.destroy
      flash[:error] = 'Image deleted'
    else
      flash[:error] = 'Not removed!!! Try Again'
    end
    redirect_to seller_product_path(current_user.seller, product)
  end

  private
    def set_image
      @image = Image.find(params[:id])
    end
    
    def image_params
      params.require(:image).permit(:product_id, :colour_id, :image)
    end
end