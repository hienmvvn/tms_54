class Course < ActiveRecord::Base
  enum status: [:free, :in_process, :closed]

  has_many :course_subjects
  has_many :user_courses
  has_many :users, through: :user_courses
  has_many :subjects, through: :course_subjects
end
