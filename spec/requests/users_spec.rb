require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/users", type: :request do
  let(:valid_attributes) {
    user=build(:user)
    user.as_json
  }


  let(:invalid_attributes) {
    user=build(:user,email:"agung@gmail")
    user.as_json
  }

  describe "POST /email-login" do
    context "with valid parameters" do
      it "return login information (token,name,etc.)" do
        create(:user)
        post login_email_url, params: { user: valid_attributes }
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      it "return error message and its status code" do
        create(:user,email:"agung1@gmail.com")
        post login_email_url, params: { user: valid_attributes }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST /email-registration" do
    context "with valid parameters" do
      
      it "creates a new User" do
        expect {
          post register_email_url, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(:ok)
      end

    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post register_email_url, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end
    end

    context "with registered email" do
      it "does not create a new User" do
        create(:user)
        expect {
          post register_email_url, params: { user: valid_attributes }
        }.to change(User, :count).by(0)
      end
    end
  end

end
