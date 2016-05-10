class Admin::CoursesController < ApplicationController
  def index
    @courses = Course.paginate page: params[:page],
      per_page: Settings.paginate.number_per_page
  end

  def new
    @course = Course.new
    @subjects = Subject.all
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "flash.create_success"
      redirect_to admin_courses_path
    else
      @subjects = Subject.all
      render :new
    end
  end

  private
  def course_params
    params.require(:course).permit :title, :description, subject_ids: []
  end
end
