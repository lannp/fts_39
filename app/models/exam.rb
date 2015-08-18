class Exam < ActiveRecord::Base  

  before_create {self.status = Settings.exams.start}
  before_create :create_answer_sheets
  before_update {self.status = Settings.exams.view}

  has_many :answer_sheets
  belongs_to :user
  belongs_to :category

  accepts_nested_attributes_for :answer_sheets, allow_destroy: true
  scope :order_desc, ->{order created_at: :desc}

  def time_remaining
    Settings.exams.minutes*60 - (Time.zone.now - self.created_at).to_i
  end

  def answer_correct
    self.answer_sheets.select{|answer_sheet| !answer_sheet.answer.nil? && 
      answer_sheet.answer.status}.length
  end

  private
  def create_answer_sheets
    Category.find(self.category_id).questions.
      order("RANDOM()").limit(Settings.questions_per_exam).each do |question|
        self.answer_sheets.build question_id: question.id
    end
  end
end
