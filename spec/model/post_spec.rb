require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }



  it 'title should be present' do
    post = Post.new(author: subject.id, title: 'Hello', text: 'This is my first post')
    post.title = nil
    expect(post).to_not be_valid
  end

  it 'comments_counter should be an integer greater than or equal to zero' do
    post = Post.new(author: subject, title: 'Hello', text: 'This is my first post')
    post.comments_counter = 'invalid'
    expect(post).to_not be_valid

    post.comments_counter = -1
    expect(post).to_not be_valid

    post.comments_counter = 0
    post.likes_counter = 0
    expect(post).to be_valid
  end

  it 'title should not be more than 250 characters' do
    post = Post.new(author: subject.id, title: 'A' * 251, text: 'This is my first post')
    expect(post).to_not be_valid
  end

  it 'likes_counter should be an integer greater than or equal to zero' do
    post = Post.new(author: subject, title: 'Hello', text: 'This is my first post')
    post.likes_counter = 'invalid'
    expect(post).to_not be_valid

    post.likes_counter = -1
    expect(post).to_not be_valid

    post.likes_counter = 0
    post.comments_counter = 0
    expect(post).to be_valid
  end
end
