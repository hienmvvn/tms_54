class Admin::UsersController < ApplicationController
  load_and_authorize_resource
  
  def index
  end

  def create
    if @user.save
      flash[:success] = t "flash.create_success"
      redirect_to admin_users_path
    else
      render :new
    end
  end
  
  def edit
    @actived_courses = @user.user_courses.in_process if @user.supervisor?
  end
 
  def update
    if @user.update_attributes user_params
      flash[:success] = t "flash.update_success"
      redirect_to admin_users_path
    else
      flash[:danger] = t "flash.update_failed"
      render :edit
    end
  end
  
  def destroy
    if @user.destroy
      flash[:success] = t "flash.delete_success"
      redirect_to admin_users_path
    else
      flash[:danger] = t "flash.delete_failed"
      redirect_to admin_users_path
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :role
  end
end
