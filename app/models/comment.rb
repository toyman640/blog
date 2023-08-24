class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post', foreign_key: :post_id

  after_create :update_post_comments_counter
  
  def update_post_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
