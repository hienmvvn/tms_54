class UserCourse < ActiveRecord::Base
  enum status: [:free, :in_process, :closed, :finished]
  
  belongs_to :course
  belongs_to :user

  has_many :user_subjects, dependent: :destroy

  scope :free_course, ->{where status: UserCourse.statuses[:free]}

  before_destroy :delete_activity
  
  private
  def delete_activity
    Activity.activity_courses(self).destroy_all
  end
end
