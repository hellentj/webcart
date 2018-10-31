class HomeController < ApplicationController
  def new
    render layout: false
  end

  def show
  end

  def index
    category = params[:category]
    unless category
      @products = Product.all
      p @products      
    else
      @products = Product.where(category_id: category)
      p @products
    end
  end  

  private 
    def home_params
      params.require(:home).permit(:category)
    end
end
