class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :answer_sheets
  has_many :exams

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  def to_param
    "#{id} #{name}".parameterize
  end
end
