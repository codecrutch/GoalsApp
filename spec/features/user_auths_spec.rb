require 'spec_helper'
require 'rails_helper'

RSpec.feature "UserAuths", type: :feature do
  subject(:user) { User.create!(email: "sean@gmail.com", password: "password") }

  feature "the signup process" do
    scenario "has a new user page" do
      visit new_user_url

      expect(page).to have_content("Create a new account")
    end

    feature "signing up a user" do

      scenario "shows username on the homepage after signup" do

        visit user_url(user)

        expect(page).to have_content(user.email)
      end
    end
  end

  feature "logging in" do
    before do
      User.create!(email: "sean@gmail.com", password: "password")
    end
    scenario "shows username on the homepage after login" do
      visit new_session_url
      expect(page).to have_content("Log in")

      fill_in 'Email', with: "sean@gmail.com"
      fill_in 'Password', with: "password"
      click_on 'Log in'

      expect(page).to have_content("Logged in as: sean@gmail.com")
    end
  end

  feature "logging out" do
    before do
      User.create!(email: "sean@gmail.com", password: "password")
    end

    scenario "begins with a logged out state" do
      visit new_session_url
      expect(page).to have_content("Log in")

      fill_in 'Email', with: "sean@gmail.com"
      fill_in 'Password', with: "password"
      click_on 'Log in'

      expect(page).to have_content("Logged in as: sean@gmail.com")

      click_on("Log out")

      expect(page).to_not have_content("Logged in as:")
    end

    scenario "doesn't show username on the homepage after logout" do
      visit new_session_url
      expect(page).to have_content("Log in")

      fill_in 'Email' , with: "sean@gmail.com"
      fill_in 'Password', with: "password"
      click_on 'Log in'
      click_on "Log out"

      expect(page).to_not have_content("Logged in as:")
    end
  end
end
