class UserCoursesController < ApplicationController
  load_and_authorize_resource
  before_action :find_course, only: [:show]

  def show
    @user_subjects = @user_course.user_subjects
    @trainee_in_course = @user_course.course.users.paginate page: params[:page],
      per_page: Settings.paginate.number_per_page
  end
  
  private
  def find_course
    @user_course = UserCourse.find_by id: params[:id]
  end
end
