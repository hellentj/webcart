class ColoursController < ApplicationController
  before_action :set_colour, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  add_breadcrumb "Home", :admins_path
  add_breadcrumb "Colours", :colours_path

  def index
    @colours = Colour.all
  end

  def show
  end

  def new
    add_breadcrumb "New Colour", new_colour_path
    @colour = Colour.new
  end

  def edit
    add_breadcrumb "Edit Colour", edit_colour_path
  end

  def create
    @colour = Colour.new(colour_params)
    if @colour.save
      flash[:success] = "Colour Successfully saved"
      redirect_to colours_path
    else
      flash[:error] = "Colour not saved, Try Again"
      render 'new'
    end
  end

  def update
    if @colour.update(colour_params)
      flash[:notice] = "Colour Successfully Updated"
      redirect_to colours_path
    else
      flash[:error] = "Colour not updated. Try Again"
      render 'edit'
    end
  end

  def destroy
    if @colour.destroy
      flash[:error] = "Colour Successfully deleted"
    else
      flash[:error] = "Colour not removed, Please Try Again"
    end
    redirect_to colours_path
  end

  private

    def set_colour
      @colour = Colour.find(params[:id])
    end
 
    def colour_params
      params.require(:colour).permit(:colour)
    end
end