class UserCourse < ActiveRecord::Base
  enum status: [:free, :in_process, :closed]
  
  belongs_to :course
  belongs_to :user

  has_many :user_subjects
end
