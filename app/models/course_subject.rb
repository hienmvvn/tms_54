class CourseSubject < ActiveRecord::Base
  enum status: [:free, :in_process, :closed]

  belongs_to :course
  belongs_to :subject

  after_update :change_user_subject_status

  private
  def change_user_subject_status
    if status_changed? && in_process?
      subject.user_subjects.each do |user_subject|
        if course.id == user_subject.user_course.course_id
          user_subject.update_attributes status: :in_process
        end
      end
    else
      subject.user_subjects.each do |user_subject|
        if course.id == user_subject.user_course.course_id
          user_subject.update_attributes status: :closed
        end
      end
    end
  end
end
