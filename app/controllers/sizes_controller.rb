class SizesController < ApplicationController
  before_action :set_size, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  add_breadcrumb "Home", :admins_path
  add_breadcrumb "Sizes", :sizes_path

  def index
    @sizes = Size.all
  end

  def show
  end

  def new
    add_breadcrumb "New Size", new_size_path
    @size = Size.new
  end

  def edit
    add_breadcrumb "Edit Size", edit_size_path
  end

  def create
    @size = Size.new(size_params)
    if @size.save
      flash[:success] = "Size is Saved"
      redirect_to sizes_path
    else
      flash[:error] = "Size is not Saved, Try Again"
      render 'new'
    end 
  end

  def update
    if @size.update(size_params)
      flash[:notice] = "Size is Updated"
      redirect_to sizes_path
    else
      flash[:error] = "Size is not updated, Try Again"
      render 'edit'
    end
  end

  def destroy
    if @size.destroy
      flash[:error] = "Size is removed"
    else
      flash[:error] = "Size is not removed, Try Again"
    end
    redirect_to sizes_path
  end

  private
    def set_size
      @size = Size.find(params[:id])
    end
   
    def size_params
      params.require(:size).permit(:size)
    end
end