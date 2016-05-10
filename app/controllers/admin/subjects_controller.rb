class Admin::SubjectsController < ApplicationController
  def index

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

  private
  def subject_params
    params.require(:subject).permit :title, :description,
      tasks_attributes: [:id, :title, :description, :_destroy]
  end
end
