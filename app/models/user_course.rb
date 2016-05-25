class UserCourse < ActiveRecord::Base
  enum status: [:free, :in_process, :closed, :finished]
  
  belongs_to :course
  belongs_to :user

  has_many :user_subjects, dependent: :destroy

  scope :free_course, ->{where status: UserCourse.statuses[:free]}

  before_destroy :delete_activity

  def all_activities
    activities = Activity.activity_courses(self)
    user_subjects.each do |user_subject|    
      activities += Activity.activity_subjects(user_subject)
      user_subject.user_tasks.each do |user_task|
        activities += Activity.activity_tasks(user_task)
      end
    end
    activities
  end

  private
  def delete_activity
    Activity.activity_courses(self).destroy_all
  end
end
