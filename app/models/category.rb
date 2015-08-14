class Category < ActiveRecord::Base
  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy
  scope :ordered_by_name, -> {order "created_at ASC"}
  validates :name, presence: true, length: {maximum: Settings.maximum_category_name_length},
    uniqueness: true
end
