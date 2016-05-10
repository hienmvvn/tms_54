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
  validate :validate

  private
  def validate
    errors.add :tasks,
      I18n.t("subject.error.at_least_two_task") unless tasks.count > 1
  end
end
