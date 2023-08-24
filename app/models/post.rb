class Post < ApplicationRecord
  belongs_to :author_id, class_name: 'User', foreign_key: :author_id_id
  has_many :comments
  has_many :likes
end