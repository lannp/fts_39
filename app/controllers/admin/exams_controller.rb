class Admin::ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @exams = Exam.all
  end
  
  def destroy  
    if @exam.destroy
      respond_to do |format|
        format.html do
          flash[:success] = t "admin.exams.destroy_success"
          redirect_to admin_exams_path
        end
        format.js
      end
    else
      flash[:danger] = t "admin.exams.destroy_faile"
      redirect_to admin_exams_path
    end   
  end

  def update
    if @exam.update exam_param
      flash[:success] = t "admin.exam.checked_success"
    else
      flash[:danger] = t "admin.exam.checked_failed"
    end
    respond_to do |format|
      format.html {redirect_to admin_exams_path}
      format.js
    end
  end

  private
  def exam_param
    params.require(:exam).permit :checked
  end
end
