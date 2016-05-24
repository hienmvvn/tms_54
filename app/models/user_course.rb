class UserCourse < ActiveRecord::Base
  enum status: [:free, :in_process, :closed, :finished]
  
  belongs_to :course
  belongs_to :user

  has_many :user_subjects

  scope :free_course, ->{where status: UserCourse.statuses[:free]}
end
