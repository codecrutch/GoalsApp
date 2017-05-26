require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  describe "new" do
    it "should render new goal form" do
      get :new
      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end

  describe "create" do
    it "should create a new goal" do
      user = User.create(email: "email", password: "password")
      post :create, goal: { title: "title", user_id: user.id }
      expect(response).to redirect_to user_url(user)
      expect(response).to have_http_status(302)
    end
  end

  describe "show" do
    it "should show the created goal" do
      user = User.create(email: "email", password: "password")
      goal = Goal.create(title: "life goals", user_id: user.id)
      get :show, id: goal.id 

      expect(response).to have_http_status(200)
    end
  end
end
