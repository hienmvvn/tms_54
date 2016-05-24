class Activity < ActiveRecord::Base
  enum action_type: [:update_profile, :follow, :unfollow,
    :finish_task, :finish_subject, :finish_course]

  belongs_to :user

  scope :latest, ->{order created_at: :desc}
  scope :activity_tasks, ->user_task{where(
    "action_type = #{Activity.action_types[:finish_task]} 
    AND target_id = #{user_task.id}")}
  scope :activity_subjects, ->user_subject{where(
    "action_type = #{Activity.action_types[:finish_subject]} 
    AND target_id = #{user_subject.id}")}
  scope :activity_courses, ->user_course{where(
    "action_type = #{Activity.action_types[:finish_course]} 
    AND target_id = #{user_course.id}")}
end
