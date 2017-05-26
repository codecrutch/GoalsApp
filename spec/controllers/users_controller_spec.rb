require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#new" do
    it "should render the new template" do
      get :new

      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end

  describe "#create" do
    context "after creating a user" do
      it "should redirect to the users page" do
        post :create, user: { email: "email", password: "password" }

        expect(response).to redirect_to(user_url(User.find_by(email: "email")))
        expect(response).to have_http_status(302)
      end
    end
    context "with invalid params" do
      it "should render new template" do
        post :create, user: { email: "email", password: ""}

        expect(response).to render_template('new')
        expect(response).to have_http_status(200)
        expect(flash[:errors]).to_not be_empty
      end
    end
  end
end
