class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :posts, table_name: :likes, column_options: { null: false } do |t|
      t.rename :user_id, :AuthorId
      t.rename :post_id, :PostId
      t.timestamps
    end
  end
end
