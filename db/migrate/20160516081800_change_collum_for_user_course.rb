class ChangeCollumForUserCourse < ActiveRecord::Migration
  def change
    change_column :user_courses, :status, :integer, default: 0
  end
end
