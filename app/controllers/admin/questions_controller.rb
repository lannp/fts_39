class Admin::QuestionsController < ApplicationController
  load_and_authorize_resource

  def new
    @category_id = params[:category_id]
    4.times {@question.answers.build}
  end

  def create
    @question = Question.new question_params
    @category = @question.category
    if @question.save
      flash[:sucess] = t "admin.question.create_success"
    else
      flash[:danger] = t "admin.question.create_failed"
    end
    respond_to do |format|
      format.html {redirect_to admin_category_path @category}
      format.js
    end
  end

  def show
  end

  def edit
  end

  def update
    @category = @question.category
    if @question.update_attributes question_params
      flash[:sucess] = t "admin.question.update_success"
      redirect_to admin_category_path @category
    else
      render :edit
      flash.now[:danger] = t "admin.question.update_failed"
    end
  end

  def destroy
    @category = @question.category
    if @question.destroy
      flash[:info] = t "admin.question.destroy_success"
    else
      flash[:danger] = t "admin.question.destroy_failed"
    end
    respond_to do |format|
      format.html {redirect_to admin_category_path @category}
      format.js
    end
  end
  
  private
  def question_params
    params.require(:question).permit :content, :category_id, answers_attributes: [:id, :content, :status]
  end
end
