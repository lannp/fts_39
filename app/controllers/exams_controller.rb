class ExamsController < ApplicationController
  before_action :logged_in_user
  
  def index
    @exams = current_user.exams.order_desc.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def create
    @exam = current_user.exams.build exam_params
    if @exam.save
      flash[:success] = t "exams.success_create"
    else
      flash[:danger] = t "exams.danger_create"
    end
    redirect_to exams_path
  end

  private
  def exam_params
    params.require(:exam)
      .permit :category_id, answer_sheets_attributes: [:id, :question_id, :answer_id]
  end
end
