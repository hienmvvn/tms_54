class CreateUserTasks < ActiveRecord::Migration
  def change
    create_table :user_tasks do |t|
      t.references :User, index: true, foreign_key: true
      t.references :Task, index: true, foreign_key: true
      t.integer :status

      t.timestamps null: false
    end
  end
end
