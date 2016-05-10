class Course < ActiveRecord::Base
  enum status: [:free, :in_process, :closed]

  has_many :course_subjects, dependent: :destroy
  has_many :user_courses
  has_many :users, through: :user_courses
  has_many :subjects, through: :course_subjects

  validates :title, presence: true, length: {minimum: 9, maximum: 90}
  validates :description, presence: true, length: {minimum: 9}
end
