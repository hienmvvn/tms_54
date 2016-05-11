class UserSubject < ActiveRecord::Base
  enum status: [:free, :in_process, :closed]

  belongs_to :subject
  belongs_to :user
  belongs_to :user_course
end
