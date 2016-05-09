class CreateCourseSubjects < ActiveRecord::Migration
  def change
    create_table :course_subjects do |t|
      t.references :Course, index: true, foreign_key: true
      t.references :Subject, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
