class Admin::CoursesController < ApplicationController
  load_and_authorize_resource
  before_action :load_subjects, only: [:new, :create, :edit, :update]
  before_action :load_user, only: [:edit, :update]

  def index
    @courses = Course.paginate page: params[:page],
      per_page: Settings.paginate.number_per_page
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @users = User.not_admin
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "flash.create_success"
    else
      @users = User.not_admin
      flash[:danger] = t "flash.create_failed"
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = t "flash.update_success"
    else
      flash[:danger] = t "flash.update_failed"
    end
    @courses = Course.paginate page: params[:page],
      per_page: Settings.paginate.number_per_page
    respond_to do |format|
      format.html
      format.js
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
    @course_subjects = @course.course_subjects.paginate page: params[:page_subject],
      per_page: Settings.paginate.number_per_page
    @users = @course.users.order_by_supervisor.paginate page: params[:page_user],
      per_page: Settings.paginate.number_per_page
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def course_params
    params.require(:course).permit :title, :description, :status,
      subject_ids: [], user_ids: []
  end

  def load_subjects
    @subjects = Subject.all
  end

  def load_user
    @users = User.not_admin.not_in_other_actived_course @course
  end
end
