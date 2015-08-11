class Exam < ActiveRecord::Base
  has_many :questions
  has_many :answer_sheets
  belongs_to :user
  belongs_to :category

  scope :order_desc, ->{order created_at: :desc}
end
