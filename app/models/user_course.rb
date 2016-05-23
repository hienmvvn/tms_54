class UserCourse < ActiveRecord::Base
  enum status: [:free, :in_process, :closed]
  
  belongs_to :course
  belongs_to :user

  has_many :user_subjects

  scope :free_course, ->{where status: UserCourse.statuses[:free]}

  def finished?
    user.user_subjects.select{|user_subject| user_subject.finished? &&
      user_subject.user_course_id == id}.count == course.subjects.count
  end
end
