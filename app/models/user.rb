class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :validatable, :timeoutable

  enum role: [:trainee, :supervisor, :admin]

  has_many :user_courses, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :user_tasks, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :subjects, through: :user_subjects
  has_many :tasks, through: :user_tasks
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  scope :not_admin, ->{where.not role: User.roles[:admin]}
  scope :not_in_actived_course, ->{where("id NOT IN(SELECT user_id FROM user_courses
    WHERE status = #{Course.statuses[:in_process]}) OR id IN(SELECT id FROM users
    WHERE(role = #{User.roles[:supervisor]}))")}
  scope :not_in_other_actived_course, ->course{where("id NOT IN(SELECT user_id FROM user_courses
    WHERE(status = #{Course.statuses[:in_process]}))
    OR id IN(SELECT id FROM users WHERE role = #{User.roles[:supervisor]})
    OR id IN(SELECT user_id FROM user_courses WHERE course_id = #{course.id})")}
  scope :order_by_supervisor, ->{order role: :desc}
  scope :in_other_actived_course, ->course{where("id IN(SELECT user_id FROM user_courses
    WHERE(course_id NOT IN(#{course.id}) AND status = #{Course.statuses[:in_process]})
    AND user_id IN(SELECT user_id FROM user_courses WHERE course_id = #{course.id}))")}
  scope :not_finished_with_current_course, ->course{where("id NOT IN(SELECT user_id FROM user_courses
    WHERE course_id = #{course.id} AND status = #{Course.statuses[:closed]})")}
  
  validates :name, presence: true, length: {minimum: 6, maximum: 20}
  validates :role, presence: true

  def is_user? user
    self == user
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  def is_supervisor_in_actived_course?
    supervisor? && !user_courses.in_process.empty?
  end
end
