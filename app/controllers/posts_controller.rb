class PostsController < ApplicationController
  def index
    @author = User.find(params[:id])
    @author_posts = Post.where(author_id: @author.id)
  end

  def show
    @specific_user = User.find(params[:user_id])
    @specific_post = Post.where(author_id: @specific_user.id).find(params[:post_id])
    @post_comments = Comment.where(post_id: @specific_post.id)
  end
end