class SellersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_seller, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Home", :sellers_path, only: [:index, :new, :edit]

  def index
    unless current_user.seller
      redirect_to new_seller_path
    else
      seller = current_user.seller
      @products = seller.products.paginate(page: params[:page], per_page: 20)
      @total = @products.count
      @pending = 0
      @blocked = 0
      seller.products.each do |product|
        if product.quantity == 0
          @pending +=1
        end
        if product.block?
          @blocked +=1
        end
      end
    end
  end

  def show
    if current_user.admin?
      add_breadcrumb "Home", admins_path
      add_breadcrumb "Profile"
      @seller = Seller.find(params[:id])
    else
      add_breadcrumb "Home", sellers_path
      add_breadcrumb "Profile", seller_path(current_user.seller)
      @seller = Seller.find(params[:id])
      authorize @seller
    end
  end

  def new
    @seller = Seller.new
  end

  def edit
    unless current_user.seller
      redirect_to new_seller_path
    end
  end

  def create
    @seller = current_user.create_seller(seller_params)
    if @seller.save
      flash[:success] = 'Profile successfully added.'
      redirect_to seller_path(@seller)
    else
      flash[:error] = 'Something went wrong!! Please Try again!!!'
      render 'new'
    end
  end

  def update
    if @seller.update(seller_params)
      flash[:notice] = 'Profile successfully updated.'
      redirect_to seller_path(current_user.seller)
    else
      flash[:error] = 'Something went wrong!! Please Try again!!!'
      render 'edit'
    end
  end

  def destroy
    if @seller.destroy
      flash[:error] = "Your account has been removed"
    else
      flash[:error] = "Your account can not be removed"
    end
  end

  private
    def set_seller
      @seller = current_user.seller
    end 

    def seller_params
      params.require(:seller).permit(:sname, :website, :description)
    end
end