class UserCoursesController < ApplicationController
  load_and_authorize_resource

  def show
    @user_subjects = @user_course.user_subjects
    @trainee_in_course = @user_course.course.users.paginate page: params[:page],
      per_page: Settings.paginate.number_per_page
  end
      
end
