class Admin::CourseSubjectsController < ApplicationController
  load_and_authorize_resource

  def update
    if @course_subject.update_attributes course_subject_params
      flash[:success] = t "flash.update_success"
    else
      flash[:danger] = t "flash.update_failed"
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def course_subject_params
    params.require(:course_subject).permit :status
  end
end
