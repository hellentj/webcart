class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end


  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category successfully created.'
      redirect_to @category
    else
      flash[:notice] = 'Try again!!'
      render 'new'
    end
  end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category successfully Updated.'
      redirect_to @category
    else
      flash[:notice] = 'Try again!!!'
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = 'Category successfully removed.'
    else
      flash[:notice] = 'Category not removed!!! Try Again'
    end
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:category_name)
    end
end