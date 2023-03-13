require 'rails_helper'

RSpec.describe "RecipeComments", type: :request do
  let(:valid_request_body) {
    recipe=create(:recipe)
    {
      "recipe_id" =>recipe.id,
      "content" => "Comment Test"
    }
  }
  let(:invalid_request_body) {
    recipe=create(:recipe)
    {
      "recipe_id" =>recipe.id,
      "content" => "C"*3001
    }
  }
  describe "GET /recipe-comments/:id" do
    headers = {
      "Authorization": "Bearer #{ENV['TEST_TOKEN']}", 
    }
    context "with valid parameters" do
      it "return recipe details" do
        user=create(:user)
        recipe=create(:recipe,user:user)
        recipe_comment=create(:recipe_comment,user:user,recipe:recipe)
        recipe_comment=create(:recipe_comment,user:user,recipe:recipe)
        get recipe_comments_url(id: recipe.id ), :headers => headers
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["data"]["recipe_comments"].length).to eq(2)
      end
      it "return ok status if recipe comment is empty" do
        user=create(:user)
        recipe=create(:recipe,user:user)
        get recipe_comments_url(id: recipe.id ), :headers => headers
        expect(response).to have_http_status(:ok)
      end
    end
    
    context "without auth token given" do
      it "return error message" do
        user=create(:user)
        recipe=create(:recipe,user:user)
        get recipe_comments_url(id: recipe.id )
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
  
  describe "POST /recipe-comment" do
    headers = {
      "Authorization": "Bearer #{ENV['TEST_TOKEN']}", 
    }
    context "with valid parameters" do
      it "return recipe details" do
        post recipe_comment_url, params: { comment: valid_request_body}, :headers => headers
        expect(response).to have_http_status(:ok)
      end
    end
    context "with invalid parameters" do
      it "return error message" do
        post recipe_comment_url, params: { comment: invalid_request_body}, :headers => headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    context "without auth token given" do
      it "return error message" do
        post recipe_comment_url, params: { comment: valid_request_body}
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
