class UserTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  belongs_to :user_subject

  before_destroy :delete_activity

  after_create :finish_subject, if: :all_tasks_was_finished?
  after_create :finish_course, if: :all_subjects_was_finished?
  after_create :create_activity
 
  private
  def all_tasks_was_finished?
    user_subject.user_tasks.count == user_subject.subject.tasks.count
  end

  def finish_subject
    user_subject.update_attributes status: :finished
  end

  def all_subjects_was_finished?
    count_finished_subject = 0
    user_course = user_subject.user_course
    user_subject.user.user_subjects.each do |user_subject|
      if user_subject.finished? && user_subject.user_course == user_course
        count_finished_subject += 1
      end
    end
    count_finished_subject == user_subject.user_course.course.subjects.count
  end

  def finish_course
    user_subject.user_course.update_attributes status: :finished
  end

  def create_activity
    Activity.create user_id: user_id,
      action_type: Activity.action_types[:finish_task], target_id: id
    if all_tasks_was_finished?
      Activity.create user_id: user_id,
        action_type: Activity.action_types[:finish_subject],
        target_id: user_subject.id
    end
    if all_subjects_was_finished?
      Activity.create user_id: user_id,
        action_type: Activity.action_types[:finish_course],
        target_id: user_subject.user_course.id
    end
  end

  def delete_activity
    Activity.activity_tasks(self).destroy_all
  end
end
