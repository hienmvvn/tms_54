class UserCoursesController < ApplicationController
  load_and_authorize_resource
  before_action :find_course, only: [:show]

  def show
    @user_subjects = @user_course.user_subjects
  end
  
  private
  def find_course
    @user_course = UserCourse.find_by id: params[:id]
  end
end
