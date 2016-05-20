class UserSubjectsController < ApplicationController
  load_and_authorize_resource

  def show
    @tasks = @user_subject.subject.tasks
    @user_id = @user_subject.user_id
    @tasks.each do |task|
      @user_subject.user_tasks.find_or_initialize_by task_id: task.id,
        user_id: @user_id
    end
  end

  def update
    if @user_subject.update_attributes user_subject_params
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".errors"
    end
    redirect_to user_subject_path 
  end

  private
  
  def user_subject_params
    params.require(:user_subject).permit user_tasks_attributes: [:id, :user_id, :task_id]
  end
end
