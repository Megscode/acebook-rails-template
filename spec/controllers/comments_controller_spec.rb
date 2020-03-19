require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:each) do
    @user = User.create!({
      :email => "test@test.com",
      :password => "password",
    })

    sign_in @user
  end

  describe "POST /" do
    it "responds with 200" do
      post :create, params: { comment: { content: "Commenty thing", user_id: "1", post_id: "1"}}
      
      expect(response).to redirect_to(posts_url)
    end
    
    it "creates a comment and re routes user" do
      post :create, params: { comment: { content: "Commenty thing", user_id: "1", post_id: "1"}}
      
      expect(response).to have_http_status(302)
    end
  end
end
