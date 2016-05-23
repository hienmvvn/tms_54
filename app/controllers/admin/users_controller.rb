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
  
  private
  def user_params
    params.require(:user).permit :name, :email, :password, :role
  end
end
