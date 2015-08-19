class ExamsController < ApplicationController
  load_and_authorize_resource

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

  def show
    @time_remaining = @exam.time_remaining
    @is_time_over = @time_remaining < 0
    @answer_sheets = Exam.find(params[:id]).answer_sheets
    @answer_correct = @exam.answer_correct
  end

  def update
    if @exam.update_attributes exam_params
      flash[:success] = t "exams.success_update"
    else
      flash[:danger] = t "exams.danger_update"
    end
    redirect_to exam_path @exam
  end

  private
  def exam_params
    params.require(:exam)
      .permit :category_id, answer_sheets_attributes: [:id, :question_id, :answer_id]
  end
end
