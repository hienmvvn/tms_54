class UserCourse < ActiveRecord::Base
  enum status: [:free, :in_process, :closed, :finished]
  
  belongs_to :course
  belongs_to :user

  has_many :user_subjects, dependent: :destroy

  scope :free_course, ->{where status: UserCourse.statuses[:free]}

  before_destroy :delete_activity

  after_create :send_assign_email

  after_destroy :send_remove_email

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

  def send_assign_email
    Mailer.assign_trainee_email(user, course).deliver_now
  end

  def send_remove_email
    Mailer.remove_trainee_email(user, course).deliver_now
  end
end
