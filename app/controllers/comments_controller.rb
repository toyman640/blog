class CommentsController < ApplicationController

  def new
    @specific_post = Post.find(params[:post_id])
    @specific_user =  User.find(params[:user_id])
  end

  def create
    @specific_post = Post.find(params[:post_id])
    @specific_user = User.find(params[:user_id])
    @comment = Comment.new(
      author_id: @specific_user.id,
      post_id: @specific_post.id,
      text: params[:text]
    )
    if @comment.save
      puts "saved"
    else
      render 'new'
      puts @comment.errors.full_messages
      puts "not saved"
    end
  end

end
