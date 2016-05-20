class UserSubject < ActiveRecord::Base
  enum status: [:free, :in_process, :closed]

  belongs_to :subject
  belongs_to :user
  belongs_to :user_course

  has_many :user_tasks

  accepts_nested_attributes_for :user_tasks, allow_destroy: true,
    reject_if: proc{|attribute|  attribute[:task_id].nil?}

  before_update :add_user_to_task

  private
  def add_user_to_task
    self.user_tasks.each do |user_task|
      user_task.user_id = self.user_id if user_task.new_record?
    end
  end
end
