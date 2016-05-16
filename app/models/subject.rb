class Subject < ActiveRecord::Base
  has_many :course_subjects
  has_many :user_subjects
  has_many :tasks, dependent: :destroy
  has_many :courses, through: :course_subjects
  has_many :users, through: :user_subjects

  accepts_nested_attributes_for :tasks,
    reject_if: ->task{task[:title].blank? || task[:description].blank?},
    allow_destroy: true

  validates :title, presence: true, length: {minimum: 9, maximum: 90}
  validates :description, presence: true, length: {minimum: 9}
  validates :tasks, length: {minimum: 2, message: I18n.t("subject.error.at_least_two_task")}

  def validate_subject subject_params
    number_of_task = 0
    subject_params["tasks_attributes"].each do |key, param|
      if param["_destroy"] == "false" &&
        param[:title].present? && param[:description].present?
          number_of_task += 1
      end
    end
    errors.add :tasks,
      I18n.t("subject.error.at_least_two_task") unless number_of_task > 1
    errors.add :title,
      I18n.t("subject.error.cannot_be_blank") unless subject_params[:title].present?
    errors.add :description,
      I18n.t("subject.error.cannot_be_blank") unless subject_params[:description].present?
  end
end
