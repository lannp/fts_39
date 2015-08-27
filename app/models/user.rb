class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  extend FriendlyId
  friendly_id :name, use: :history
  has_many :answer_sheets
  has_many :exams, dependent: :destroy

  def to_param
    "#{id} #{name}".parameterize
  end
end
