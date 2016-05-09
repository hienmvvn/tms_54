class CreateUserSubjects < ActiveRecord::Migration
  def change
    create_table :user_subjects do |t|
      t.references :Subject, index: true, foreign_key: true
      t.references :User, index: true, foreign_key: true
      t.references :User_Course, index: true, foreign_key: true
      t.integer :status

      t.timestamps null: false
    end
  end
end
