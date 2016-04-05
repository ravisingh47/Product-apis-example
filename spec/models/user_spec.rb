require 'rails_helper'

RSpec.describe User, :type => :model do

  describe "#password encryption" do
    let(:user) { create :user }
    let(:sample_request) do
      {
        first_name: "Bruce",
        last_name: "Wayne",
        email: "bruce@gotham.com",
        password: "iambatman",
        mobile_number: "8603740623"
      }
    end

    context "Read password" do
      it "successfuly reads password" do
        expect(user.password).to eq("janedoe123")
      end
    end

    context "Write password" do
      before :each do
        @new_user = User.create(sample_request)
      end

      it "successfuly writes password" do
        expect(@new_user.password).to eq(sample_request[:password])
      end

      it "expected password to be stored in encrypted form" do
        expect(@new_user.encrypted_password).not_to be_blank
      end
    end
  end

  describe "#generate_auth_token" do
    let(:users) { create_list :user, 50 }

    let(:sample_request) do
      {
        first_name: "Bruce",
        last_name: "Wayne",
        email: "bruce@gotham.com",
        password: "iambatman",
        mobile_number: "8603740623"
      }
    end

    before :each do
      @new_user = User.create(sample_request)
    end

    it "allways creates an auth_token" do
      expect(@new_user.auth_token).not_to be_blank
    end

    it "creates an unique auth token for user" do
      user_with_common_token = User
                               .where(auth_token: @new_user.auth_token)
    
      expect(user_with_common_token.count).to eq(1)
    end
  end
end
