class Course < ActiveRecord::Base
  enum status: [:free, :in_process, :closed]

  has_many :course_subjects, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses
  has_many :subjects, through: :course_subjects

  validates :title, presence: true, length: {minimum: 9, maximum: 90}
  validates :description, presence: true, length: {minimum: 9}

  after_update :assign_subject_to_trainee, if: :status_changed_to_in_process?
  after_update :close_all_user_course, if: :status_changed_to_closed?
  after_update :close_all_course_subject, if: :status_changed_to_closed?

  def trainee_already_in_other_actived_course
    User.in_other_actived_course(self).not_finished_with_current_course self
  end

  def compare_user_and_send_mail before_user_ids
    after_user_ids = self.user_ids
    before_user_ids.each do |before_user_id|
      unless after_user_ids.include? before_user_id
        before_user = User.find before_user_id
        Mailer.remove_trainee_email(before_user, self).deliver_now
      end
    end
  end

  private
  def assign_subject_to_trainee
    users.trainee.each do |trainee|
      user_course = trainee.user_courses.find_by course_id: id
      user_course.update_attributes status: :in_process unless user_course.finished?
      subjects.each do |subject|
        UserSubject.find_or_create_by user: trainee,
          subject: subject, user_course: user_course
      end
    end
  end

  def close_all_user_course
    users.trainee.each do |trainee|
      user_course = trainee.user_courses.find_by course_id: id
      user_course.update_attributes status: :closed unless user_course.finished?
    end
  end

  def close_all_course_subject
    course_subjects.each do |course_subject|
      course_subject.update_attributes status: :closed
    end
  end

  def status_changed_to_in_process?
    status_changed? && in_process?
  end

  def status_changed_to_closed?
    status_changed? && closed?
  end
end
