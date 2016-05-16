class Admin::CoursesController < ApplicationController
  load_and_authorize_resource

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
    @users = User.not_admin
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = t "flash.update_success"
      redirect_to admin_courses_path
    else
      flash[:danger] = t "flash.update_failed"
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

  def show
    @subjects = @course.subjects.paginate page: params[:page_subject],
      per_page: Settings.paginate.number_per_page
    @users = @course.users.paginate page: params[:page_user],
      per_page: Settings.paginate.number_per_page
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def course_params
    params.require(:course).permit :title, :description, subject_ids: [], user_ids: []
  end
end
