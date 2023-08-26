class Like < ApplicationRecord
  belongs_to :post, class_name: 'Post', counter_cache: true
  belongs_to :author, class_name: 'User', foreign_key: :author_id
end
