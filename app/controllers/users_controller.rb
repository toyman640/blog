class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @specific_user = User.find(params[:id])
    @user_post = @specific_user.recent_posts
  end
end
