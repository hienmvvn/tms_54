class Admin::SubjectsController < ApplicationController
  before_action :find_subject, only: [:destroy, :edit, :update]

  def index
    @subjects = Subject.paginate page: params[:page],
      per_page: Settings.paginate.number_per_page
  end

  def new
    @subject = Subject.new
    Settings.subject.number_task_default.times do
      @task = @subject.tasks.build
    end
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "flash.create_success"
      redirect_to admin_subjects_path
    else
      render :new
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = t "flash.delete_success"
      redirect_to admin_subjects_path
    else
      flash[:danger] = t "flash.delete_failed"
      redirect_to admin_subjects_path
    end
  end

  def edit
  end

  def update
    @subject.validate_subject subject_params
    if @subject.errors.count > 0
      render :edit
    else
      if @subject.update_attributes subject_params
        flash[:success] = t "flash.update_success"
        redirect_to admin_subjects_path
      else
        render :edit
      end
    end
  end

  private
  def subject_params
    params.require(:subject).permit :title, :description,
      tasks_attributes: [:id, :title, :description, :_destroy]
  end

  def find_subject
    @subject = Subject.find_by id: params[:id]
    unless @subject
      flash[:danger] = t "subject.error.no_subject_found", id: params[:id]
      redirect_to admin_subjects_path
    end
  end
end
