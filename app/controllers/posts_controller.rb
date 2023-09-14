class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @author = User.find(params[:id])
    @author_posts = Post.includes(:comments).where(author_id: @author.id)
    @post_comments = []
    @author_posts.each do |post|
      @post_comments.concat(post.recent_comments)
    end
  end

  def show
    @specific_user = User.find(params[:user_id])
    @specific_post = Post.where(author_id: @specific_user.id).find(params[:id])
    @post_comments = Comment.where(post_id: @specific_post.id)
  end

  def new
    @new_post = Post.new
  end

  def create
    @new_post = Post.new(post_params)
    @new_post.author_id = current_user.id

    if @new_post.save
      redirect_to users_path, notice: 'Post was successfully created.'
    else
      flash.now[:alert] = 'Failed to create the post.'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
