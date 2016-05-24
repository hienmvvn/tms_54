class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.trainee
  end

  def show
    @user_courses = @user.user_courses
    @activities = @user.activities.latest
  end
end
