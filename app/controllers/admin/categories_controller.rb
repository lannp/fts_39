class Admin::CategoriesController < ApplicationController
  before_action :init_category, except: [:new, :index, :create]
  load_and_authorize_resource

  def index
    @categories = Category.ordered_by_name.paginate page: params[:page], per_page: Settings.per_page
    @category = Category.new
  end
  
  def create
    @category = Category.new category_params
    if @category.save
      respond_to do |format|
        format.html do
          flash[:success] = t "admin.category.create_success"
          redirect_to admin_categories_path
        end
        format.js
      end
    else
      flash[:success] = t "admin.category.create_failed"
      @categories = Category.ordered_by_name.paginate page: params[:page], per_page: Settings.per_page
      render :index
    end
  end

  def show
    @questions = @category.questions
  end

  def edit   
  end

  def update
    if @category.update category_params
      flash[:success] = t "admin.category.update_success"
      redirect_to admin_categories_path
    else
      flash.now[:danger] = t "admin.category.update_failed"
      render :edit
    end
  end
    
  def destroy
    if @category.destroy
      respond_to do |format|
        format.html do
          flash[:success] = t "admin.category.destroy.success"
          redirect_to admin_categories_path
        end
        format.js
      end
    else
      flash[:danger] = t "admin.category.destroy.failed"
      redirect_to admin_categories_path
    end
  end

  private
  def init_category
    @category = Category.find params[:id]
  end

  def category_params
    params.require(:category).permit :name
  end
end
