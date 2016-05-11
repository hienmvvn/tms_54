class StaticPagesController < ApplicationController
  def home
    @courses = current_user.user_courses
  end
end
