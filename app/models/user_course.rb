class UserCourse < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  has_many :user_subjects
end
