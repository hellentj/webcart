class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Home", :admins_path
  add_breadcrumb "Categories", :categories_path

  def index
    @categories = Category.all
  end

  def new
    add_breadcrumb "New Category", new_category_path
    @category = Category.new
  end

  def edit
    add_breadcrumb "Edit Category", edit_category_path
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Category successfully created.'
      redirect_to categories_path
    else
      flash[:error] = 'Please Try again !!'
      render 'new'
    end
  end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category successfully Updated.'
      redirect_to categories_path
    else
      flash[:error] = 'Category not updated!!! Please Try again!!!'
      render 'edit'
    end
  end

  def destroy
    if @category.destroy
      flash[:error] = 'Category successfully removed.'
    else
      flash[:error] = 'Category not removed!!! Try Again'
    end
    redirect_to categories_path
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:category_name)
    end
end