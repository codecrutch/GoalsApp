# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "class methods" do
    subject(:valid_user) { User.create!(email: "legit@email.com",
                                       password: "2lejit2quit") }

    describe "User::find_by_credentials" do
      it "should find a valid user" do
        user = User.find_by_credentials(valid_user.email, valid_user.password)

        expect(user).to eq(valid_user)
      end

      it "should return nil with invalid credentials" do
        user = User.find_by_credentials(valid_user.email, "im boguuuz")

        expect(user).to be nil
      end
    end

    describe "User::generate_session_token" do
      it "should use SecureRandom" do
        expect(SecureRandom).to receive(:urlsafe_base64).with(16)
        token = User.generate_session_token
      end
      it "returns a session token" do
        token = User.generate_session_token
        expect(token).to_not be_empty
        expect(token.length).to eq(22)
      end
    end

    describe "user#reset_session_token!" do
      it "should reset session token" do
        original_token = valid_user.session_token

        valid_user.reset_session_token!

        expect(valid_user.session_token).to_not eq(original_token)
      end
    end

    describe "user#password=" do
      it "should set the password digest" do
        old_digest = valid_user.password_digest

        expect(BCrypt::Password).to receive(:create).with("12345")
        valid_user.password = "12345"

        expect(valid_user.password_digest).to_not eq(old_digest)
      end
    end

    describe "user#is_password?" do
      it "should return true if correct password is given" do
        expect(valid_user.is_password?("2lejit2quit")).to be true
      end
      it "should return false if password is wrong" do
        expect(valid_user.is_password?("NOTLEGITYO")).to be false
      end
    end

  end

  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :session_token }
    it { should validate_presence_of :password_digest }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe "associations" do
  end
end
