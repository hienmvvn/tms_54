class Admin::CoursesController < ApplicationController
  before_action :find_course, only: [:edit, :update, :destroy]

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

  def edit
    @subjects = Subject.all
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = t "flash.update_success"
      redirect_to admin_courses_path
    else
      @subjects = Subject.all
      render :edit
    end
  end

  def destroy
    if @course.destroy
      flash[:success] = t "flash.delete_success"
      redirect_to admin_courses_path
    else
      flash[:danger] = t "flash.delete_failed"
      redirect_to admin_courses_path
    end
  end

  private
  def course_params
    params.require(:course).permit :title, :description, subject_ids: []
  end

  def find_course
    @course = Course.find_by id: params[:id]
    unless @course
      flash[:danger] = t "course.error.no_course_found", id: params[:id]
      redirect_to admin_courses_path
    end
  end
end
