class UserSubjectsController < ApplicationController
  load_and_authorize_resource
  before_action :find_subject, only: [:show]

  def show
    @tasks = @user_subject.subject.tasks
  end

  private
  def find_subject
    @user_subject = UserSubject.find_by id: params[:id]
  end
end
