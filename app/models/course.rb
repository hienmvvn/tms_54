class Course < ActiveRecord::Base
  enum status: [:free, :in_process, :closed]

  has_many :course_subjects, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses
  has_many :subjects, through: :course_subjects

  validates :title, presence: true, length: {minimum: 9, maximum: 90}
  validates :description, presence: true, length: {minimum: 9}

  after_update :assign_subject_to_trainee, if: :status_changed_to_in_process?
  after_update :remove_trainee_from_free_course, if: :status_changed_to_in_process?
  after_update :close_all_user_course, if: :status_changed_to_closed?

  private
  def assign_subject_to_trainee
    users.trainee.each do |trainee|
      user_course = trainee.user_courses.find_by course_id: id
      user_course.update_attributes status: :in_process
      subjects.each do |subject|
        UserSubject.find_or_create_by user: trainee,
          subject: subject, user_course: user_course
      end
    end
  end

  def remove_trainee_from_free_course
    users.trainee.each do |trainee|
      trainee.user_courses.free_course.destroy_all
    end
  end

  def close_all_user_course
    users.trainee.each do |trainee|
      user_course = trainee.user_courses.find_by course_id: id
      user_course.update_attributes status: :closed
    end
  end

  def status_changed_to_in_process?
    status_changed? && in_process?
  end

  def status_changed_to_closed?
    status_changed? && closed?
  end
end
