class Admin::ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @exams = Exam.all
  end
  
  def destroy
    @exam = Exam.find params[:id]
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
end
