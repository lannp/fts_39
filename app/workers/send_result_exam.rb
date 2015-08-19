class SendResultExam
  include Sidekiq::Worker
  
  def perform exam_id
    exam = Exam.find exam_id
    UserMailer.send_result_exam(exam).deliver_now
  end
end
