class AddUserSubjectToUserTasks < ActiveRecord::Migration
  def change
    add_reference :user_tasks, :user_subject, index: true, foreign_key: true
  end
end
