class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def new
    @specific_post = Post.find(params[:post_id])
    @specific_user = User.find(params[:user_id])
  end

  def create
    @specific_post = Post.find(params[:post_id])
    @specific_user = User.find(params[:user_id])
    @comment = Comment.new(
      author_id: current_user.id,
      post_id: @specific_post.id,
      text: params[:text]
    )
    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
      redirect_to user_post_path(@specific_user, @specific_post)
    else
      render :new
    end
  end
end
