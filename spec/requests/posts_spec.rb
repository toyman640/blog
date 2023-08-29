require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /users/:id/posts" do
    
    let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
    it "returns success http status code" do
      get "/users/#{user.id}/posts"
      expect(response.status).to eq(200)
    end

    it "returns correct template" do
      get "/users/#{user.id}/posts"
      expect(response).to render_template("posts/index")
    end

    it "returns body that include placeholder text" do
      get "/users/#{user.id}/posts"
      expect(response.body).to include("Number of posts: x")
    end
  end
end