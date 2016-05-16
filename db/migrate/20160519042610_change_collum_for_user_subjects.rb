class ChangeCollumForUserSubjects < ActiveRecord::Migration
  def change
    change_column :user_subjects, :status, :integer, default: 0
  end
end
