class SellersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_seller, only: [:show, :edit, :update, :destroy]
  
  def index    
    unless current_user.seller   
      redirect_to new_seller_path
    else
      @sellers = Seller.all 
    end
  end

  def show    
    @seller = current_user.seller
  end

  def new
    @seller = Seller.new
  end

  def edit
  end

  def create
    @seller = current_user.create_seller(seller_params)
    if @seller.save
      flash[:notice] = 'Profile successfully added.'
      redirect_to @seller
    else
      flash[:notice] = 'Try again!!!'
      render 'new'
    end
  end

  def update    
    if @seller.update(seller_params)
      flash[:notice] = 'Profile successfully added.'
      redirect_to @seller
    else
      flash[:notice] = 'Try again!!!'
      redirect_to new_seller_path
    end
  end

  def destroy
    @seller.destroy
  end

  private
    def set_seller
      @seller = current_user.seller
    end 

    def seller_params
      params.require(:seller).permit(:sname, :website, :description)
    end
end