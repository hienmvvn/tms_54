class Activity < ActiveRecord::Base
  enum action_type: [:follow, :unfollow,
    :finish_task, :finish_subject, :finish_course]

  belongs_to :user
end
