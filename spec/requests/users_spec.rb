require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

    it 'it returns success http status code' do
      get '/users'
      expect(response.status).to eq(200)
    end

    it 'returns the correct template' do
      get '/users'
      expect(response).to render_template('users/index')
    end

    it 'returns body that include placeholder text' do
      get '/users'
      expect(response.body).to include('All Users')
    end

    it 'returns specific user when id is supplied' do
      get "/users/#{user.id}"

      expect(response.status).to eq(200)
      expect(user.name).to eq('Tom')
    end
  end
end
