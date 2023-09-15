require 'rails_helper'

RSpec.describe 'Post Show Page', type: :system do
  describe 'Post Show  page' do
    before(:each) do
      # Create test users
      @user1 = User.create(name: 'User1', bio: 'Bio1', photo: 'https://images.pexels.com/photos/1405963/pexels-photo-1405963.jpeg?auto=compress&cs=tinysrgb&w=600')
      @user2 = User.create(name: 'User2', bio: 'Bio2', photo: 'https://images.pexels.com/photos/1405963/pexels-photo-1405963.jpeg?auto=compress&cs=tinysrgb&w=600')

      # Create test posts
      @post1 = Post.create(title: 'Post 1', text: 'Post 1 content', author: @user1)
      @post2 = Post.create(title: 'Post 2', text: 'Post 2 content', author: @user1)
      @post3 = Post.create(title: 'Post 3', text: 'Post 3 content', author: @user2)

      # Create test comments
      @comment1 = Comment.create(post: @post1, text: 'comment 1 content', author_id: @user1)
      @comment2 = Comment.create(post: @post1, text: 'comment 2 content', author_id: @user1)
      @comment3 = Comment.create(post: @post2, text: 'comment 3 content', author_id: @user2)

      # Create test likess
      @like1 = Like.create(post: @post1, author: @user1)
      @like2 = Like.create(post: @post1, author: @user1)
      @like3 = Like.create(post: @post2, author: @user2)
    end

    it 'displays the post title' do
      visit user_post_path(user_id: @user1, id: @post1)
      expect(page).to have_content(@post1.title)
    end

    it 'displays the author of the post' do
      visit user_post_path(user_id: @user1, id: @post1)
      expect(page).to have_content(@post1.author.name)
    end

    it 'displays how many comments the post has' do
      visit user_post_path(user_id: @user1, id: @post1)
      expect(page).to have_content(@post1.comments_counter)
    end

    it 'displays how many likes the post has' do
      visit user_post_path(user_id: @user1, id: @post1)
      expect(page).to have_content(@post1.likes_counter)
    end

    it 'displays the post body' do
      visit user_post_path(user_id: @user1, id: @post1)
      expect(page).to have_content(@post1.text)
    end

    it 'displays the username of each commentor' do
      visit user_post_path(user_id: @user1, id: @post1)
      Comment.where(post: @post1).each do |comment|
        expect(page).to have_content(comment.author.name)
      end
    end

    it 'displays the comment left by each commentor' do
      visit user_post_path(user_id: @user1, id: @post1)
      Comment.where(post: @post1).each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end
end
