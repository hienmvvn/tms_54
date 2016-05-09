class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :User, index: true, foreign_key: true
      t.integer :action_type
      t.integer :target_id

      t.timestamps null: false
    end
  end
end
