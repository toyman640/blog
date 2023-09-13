class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
  end

  def show
    @specific_user = User.find(params[:id])
    @user_post = @specific_user.recent_posts
  end
end
