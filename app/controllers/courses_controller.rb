class CoursesController < ApplicationController
  before_action :find_course

  def show
    @user_subjects = @course.user_subjects
  end
  
  private
  def find_course
    @course = UserCourse.find params[:id]
  end
end
