require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  it 'title should be present' do
    post = Post.new(author: subject, title: 'Hello', text: 'This is my first post')
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
    post = Post.new(author: subject, title: 'A' * 251, text: 'This is my first post')
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

  it 'returns the five most recent comments' do
    user = User.create(name: 'Billy', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Nile.')
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post')

    old_comments = []
    3.times { old_comments << Comment.create(post: post.id, author: user.id) }
    
    new_comments = []
    5.times { new_comments << Comment.create(post: post.id, author: user.id) }

    # Print out the comments associated with the post for debugging
    puts "Old Comments: #{post.comments.inspect}"
    puts "New Comments: #{new_comments.inspect}"

    recent_comments = post.recent_comments

    expect(recent_comments).to eq(new_comments.reverse)
  end
  # ============================
  it 'updates comments_counter when comments are added' do
    post = Post.create(author: subject, title: 'Hello', text: 'This is my first post')

    expect {
      Comment.create(post: post, author: subject)
    }.to change { post.comments_counter }.by(1)
  end

  it 'updates likes_counter when likes are added' do
    post = Post.create(author: subject, title: 'Hello', text: 'This is my first post')

    expect {
      Like.create(post: post, author: subject)
    }.to change { post.likes_counter }.by(1)
  end

  it 'increments user posts_counter after post creation' do
    expect {
      Post.create(author: subject, title: 'Hello', text: 'This is my first post')
      subject.reload
    }.to change { subject.posts_counter }.by(1)
  end

end
