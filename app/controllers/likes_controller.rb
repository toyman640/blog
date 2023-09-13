class LikesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = Like.create(
      author_id: @user.id,
      post_id: @post.id
    )
    redirect_to user_post_path(@user, @post)
  end
end
