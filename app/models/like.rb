class Like < ApplicationRecord
  belongs_to :post, class_name: 'Post'
  belongs_to :author_id, class_name: 'User'
end
