class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :validatable, :timeoutable

  enum role: [:trainee, :supervisor, :admin]

  has_many :user_courses, dependent: :destroy
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

  scope :not_admin, ->{where.not role: User.roles[:admin]}
  scope :not_in_other_course, ->{where("id NOT IN(SELECT user_id FROM user_courses
    WHERE(status = #{Course.statuses[:in_process]}))
    OR id IN(SELECT id FROM users WHERE role = #{User.roles[:supervisor]})")}

  def is_user? user
    self == user
  end
end
