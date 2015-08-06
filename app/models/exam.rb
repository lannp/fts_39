class Exam < ActiveRecord::Base
  has_many :questions
  has_many :answer_sheets
end
