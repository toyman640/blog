require 'rails_helper'

RSpec.describe 'User Index Page', type: :system do
  describe 'Users Index page' do
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
    it 'I can see the user\'s profile picture' do
      visit post_path(@user1)
      expect(page).to have_css("img[src*='https://images.pexels.com/photos/1405963/pexels-photo-1405963.jpeg?auto=compress&cs=tinysrgb&w=600']")
    end

    it 'I can see the user\'s username' do
      visit post_path(@user1)
      expect(page).to have_content(@user1.name)
    end

    it 'I can see the number of posts the user has written.' do
      visit post_path(@user1)
      expect(page).to have_content('Number of posts: 2')
    end

    it 'I can see a post\s title' do
      visit post_path(@user1)
      expect(page).to have_content(@post1.title)
    end

    it 'I can see some of the post\'s body' do
      visit post_path(@user1)
      expect(page).to have_content(@post1.text)
    end

    it 'displays the first comments on a post' do
      visit post_path(@user1)
      @post1.recent_comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end

    it 'displays how many comments a post has' do
      visit post_path(@user1)
      expect(page).to have_content(@post1.comments_counter)
    end

    it 'displays how many likes a post has' do
      visit post_path(@user1)
      expect(page).to have_content(@post1.likes_counter)
    end

    it 'displays a section for pagination if there are more posts than fit on the view' do
      visit post_path(@user1)
      expect(page).to have_selector('.pagination')
    end

    it 'redirects to the post show page when a post is clicked' do
      visit post_path(@user1)
      find("a[href='#{user_post_path(@user1.id, @post1.id)}']").click
      expect(page).to have_current_path(user_post_path(@user1.id, @post1.id))
    end
  end
end
