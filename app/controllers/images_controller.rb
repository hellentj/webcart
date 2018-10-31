class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  def index
    @images = Image.all
  end

  def show      
  end

  def new
    @image = Image.new
  end

  def edit
  end


  def create
    @image = Image.new(image_params)
    if @image.save
      flash[:notice] = 'Image successfully added.'
      redirect_to @image
    else
      flash[:notice] = 'Try again!!!'
      render 'new'
    end
  end

  def update
    if @image.update(image_params)
      flash[:notice] = 'successfully updated.'
      redirect_to @image
    else
      flash[:notice] = 'Try again!!!'
      redirect_to new_image_path
    end  
  end

  def destroy
    if @image.destroy
      flash[:notice] = 'Image deleted'
    else
      flash[:notice] = 'Not removed!!! Try Again'
    end         
  end

  private   
    def set_image
      @image = Image.find(params[:id]) 
    end
    
    def image_params
      params.require(:image).permit(:colour_id, :image)
    end
end
