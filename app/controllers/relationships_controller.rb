class RelationshipsController < ApplicationController  
  def create
    @user = User.find params[:followed_id]
    unless current_user.following? @user
      if current_user.follow @user
        respond_to do |format|
          format.html {redirect_to @user}
          @status = true
          format.js 
        end
      else
        respond_to do |format|
          @status = false
          format.js
        end
      end
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    if current_user.following? @user
      if current_user.unfollow @user 
        respond_to do |format|
          format.html {redirect_to @user}
          @status = true
          format.js
        end
      else
        respond_to do |format|
          @status = false
          format.js
        end
      end
    end
  end
end
