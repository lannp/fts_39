class ExamsController < ApplicationController

  before_action :logged_in_user
  before_action :init_exam, only: [:show, :update]

  def show
    @time_remaining = @exam.time_remaining
    @is_time_over = @time_remaining < 0
  end
  
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

  def update
    if @exam.update_attributes exam_params
      flash[:success] = t "exams.success_update"
    else
      flash[:danger] = t "exams.danger_update"
    end
    redirect_to exam_path @exam
  end

  private
  def init_exam
    @exam = Exam.find params[:id]
  end

  def exam_params
    params.require(:exam)
      .permit :category_id, answer_sheets_attributes: [:id, :question_id, :answer_id]
  end
end
