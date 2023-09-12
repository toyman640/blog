require 'rails_helper'

RSpec.describe 'User Show Page', type: :system do
  describe 'User Show page' do
    before(:each) do
      # Create test users
      @user1 = User.create(name: 'User1', bio: 'Bio1', photo: 'https://images.pexels.com/photos/1405963/pexels-photo-1405963.jpeg?auto=compress&cs=tinysrgb&w=600')
      @user2 = User.create(name: 'User2', bio: 'Bio2', photo: 'https://images.pexels.com/photos/1405963/pexels-photo-1405963.jpeg?auto=compress&cs=tinysrgb&w=600')

      # Create test posts
      @post1 = Post.create(title: 'Post 1', text: 'Post 1 content', author: @user1)
      @post2 = Post.create(title: 'Post 2', text: 'Post 2 content', author: @user1)
      @post3 = Post.create(title: 'Post 3', text: 'Post 3 content', author: @user2)
    end
    it 'I can see the user\'s profile picture' do
      visit user_path(@user1)
      expect(page).to have_css("img[src*='https://images.pexels.com/photos/1405963/pexels-photo-1405963.jpeg?auto=compress&cs=tinysrgb&w=600']")
    end

    it 'I can see the user\'s user name' do
      visit user_path(@user1)
      expect(page).to have_content(@user1.name)
    end

    it 'I can see the number of posts the user has written' do
      visit user_path(@user1)
      expect(page).to have_content('Number of posts: 2')
    end

    it 'I can see the user\'s bio' do
      visit user_path(@user1)
      expect(page).to have_content(@user1.bio)
    end

    it 'displays the user\'s first 3 posts' do
      visit user_path(@user1)
      expect(page).to have_content(@post1.title)
      expect(page).to have_content(@post2.title)
      expect(page).to_not have_content(@post3.title)
    end

    it 'displays a button to view all of a user\'s posts' do
      visit user_path(@user1)
      expect(page).to have_link('See all posts', href: post_path(@user1))
    end

    it 'redirects to the user\'s post show page when a user\'s post is clicked' do
      visit user_path(@user1)
      find("a[href='#{user_post_path(@user1.id, @post1.id)}']").click
      expect(page).to have_current_path(user_post_path(@user1.id, @post1.id))
    end

    it 'redirects to the user\'s post index page when "See all posts" is clicked' do
      visit user_path(@user1)
      click_link 'See all posts'
      expect(page).to have_current_path(post_path(@user1))
    end
  end
end
