class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @user_courses = @user.user_courses
  end
end
