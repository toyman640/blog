class Post < ApplicationRecord
  belongs_to :author_id, class_name: 'User', foreign_key: :author_id_id
  has_many :comments
  has_many :likes

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_comments_counter
    update(comments_counter: comments.count)
  end

  def update_likes_counter
    update(likes_counter: likes.count)
  end
end