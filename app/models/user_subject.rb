class UserSubject < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user
  belongs_to :user_course
end
