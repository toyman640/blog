class Like < ApplicationRecord
  belongs_to :post, class_name: 'Post'
  belongs_to :author, class_name: 'User', foreign_key: :author_id
end
