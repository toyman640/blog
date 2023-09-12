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
    end

    it 'i can see usernames of all users' do
      visit users_path

      expect(page).to have_content(@user1.name)
      expect(page).to have_content(@user2.name)
    end

    it 'I can see the profile picture gor each user' do
      visit users_path(@user1)
      expect(page).to have_css("img[src*='https://images.pexels.com/photos/1405963/pexels-photo-1405963.jpeg?auto=compress&cs=tinysrgb&w=600']")
    end

    it 'I can see the number of posts each user has written' do
      visit users_path

      expect(page).to have_content('Number of posts: 2')
      expect(page).to have_content('Number of posts: 1')
    end

    it 'When I click on a user, I am redirected to that user\'s show page' do
      visit users_path

      within('.cards', text: @user1.name) do
        find('.card-link').click
      end

      expect(page).to have_selector('.container', wait: 10)
      expect(page).to have_current_path(user_path(@user1))
    end
  end
end
