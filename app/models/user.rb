class User < ActiveRecord::Base
  has_many :user_courses
  has_many :user_subjects
  has_many :user_tasks
  has_many :activities, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :subjects, through: :user_subjects
  has_many :tasks, through: :user_tasks
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :follower, through: :passive_relationships, source: :follower

  has_secure_password
end
