class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_create :increment_user_posts_counter
  before_destroy :decrement_user_posts_counter

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_comments_counter
    update(comments_counter: comments.count)
    reload
  end

  def update_likes_counter
    update(likes_counter: likes.count)
    reload
  end

  def increment_user_posts_counter
    author.update_posts_counter
  end

  def decrement_user_posts_counter
    author.decrement!(:posts_counter)
  end
end
