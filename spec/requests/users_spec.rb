require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "it returns success http status code" do
      get "/users"
      expect(response.status).to eq(200)
    end

    it "returns the correct template" do
      get "/users"
      expect(response).to render_template("users/index")
    end

    it "returns body that include placeholder text" do
      get "/users"
      expect(response.body).to include("All Users")
    end
  end
end