class Comment < ApplicationRecord
  belongs_to :author_id, class_name: 'User'
  belongs_to :post, class_name: 'Post', foreign_key: :post_id
end