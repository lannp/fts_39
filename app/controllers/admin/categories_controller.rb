class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = Category.ordered_by_name.paginate page: params[:page], per_page: Settings.per_page
    @category = Category.new
  end
  
  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "admin.category.create_success"   
    else
      flash[:success] = t "admin.category.create_failed"
      @categories = Category.ordered_by_name.paginate page: params[:page], per_page: Settings.per_page
    end
    respond_to do |format|
      format.html {redirect_to admin_categories_path}
      format.js
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
      flash[:success] = t "admin.category.destroy.success"     
    else
      flash[:danger] = t "admin.category.destroy.failed"
      redirect_to admin_categories_path
    end
    respond_to do |format|
      format.html {redirect_to admin_categories_path}
      format.js
    end
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end
