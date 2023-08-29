class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @specific_user = User.find(params[:id])
    @user_post = Post.where(author_id: @specific_user.id)
  end
end
