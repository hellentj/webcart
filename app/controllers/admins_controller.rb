class AdminsController < ApplicationController
  before_action :set_user, only: [:block_user, :unblock_user]
  add_breadcrumb "Home", :admins_path

  def index
  end

  def show
    add_breadcrumb "Users", admin_path
    @customers = Customer.all.paginate(page: params[:page], per_page: 20)
  end

  def sellers_list
    add_breadcrumb "Sellers", sellers_list_admin_path(current_user)
    @sellers = Seller.all.paginate(page: params[:page], per_page: 20)
  end

  def new_seller_requests
    add_breadcrumb "New Sellers", new_seller_requests_admin_path
    @sellers = Seller.pending.paginate(page: params[:page], per_page: 20)
  end

  def products_all
    add_breadcrumb "Sellers", sellers_list_admin_path(current_user)
    add_breadcrumb "Products", products_all_admin_path
    seller = Seller.find(params[:seller])
    @products = seller.products.paginate(page: params[:page], per_page: 20)
  end

  def product_details
    add_breadcrumb "Sellers", sellers_list_admin_path(current_user)
    @product = Product.find(params[:id])
    @images = @product.images
    add_breadcrumb "Products", products_all_admin_path(seller: @product.seller)
    add_breadcrumb @product.product_name, product_details_admin_path(@product)
  end

  def block_user
    @user.status = "block"
    if @user.save
      flash[:error] = "Successfully blocked"
    else
      flash[:notice] = "Couldn't block, Please try Again!!!"
    end
    if @path == "User" && @user.seller? 
      redirect_to sellers_list_admin_path(current_user)
    elsif @path == "User" && @user.customer?
      redirect_to admin_path(current_user)
    else    
      redirect_to products_all_admin_path(current_user, seller: @user.seller)
    end
  end

  def unblock_user
    @user.status = "unblock"
    if @user.save
      flash[:success] = "Successfully unblocked"
    else
      flash[:notice] = "Couldn't unblock user, Please try Again!!!"
    end
    if @path == "User" && @user.seller? 
      redirect_to sellers_list_admin_path(current_user)
    elsif @path == "User" && @user.customer?
      redirect_to admin_path(current_user)
    else
      redirect_to products_all_admin_path(current_user, seller: @user.seller)
    end
  end

  def update
    @seller = Seller.find(params[:seller])
    @seller.status = "approved"
    if @seller.save
      flash[:notice] = "Seller has been approved"
    else
      flash[:error] = "Couldn't approve seller, Try Again!!!"
    end
    redirect_to admins_path
  end


  private

    def set_user
      if params[:product].present?
        @user = Product.find(params[:product])
        @path = "product"
      else 
        @user = User.find(params[:user])
        @path = "User"
      end
    end

end