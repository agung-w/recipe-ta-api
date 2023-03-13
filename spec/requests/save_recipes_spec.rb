require 'rails_helper'

RSpec.describe "SaveRecipes", type: :request do
  describe "PUT /save-recipe/:id" do
    headers = {
      "Authorization": "Bearer #{ENV['TEST_TOKEN']}", 
    }
    context "with valid parameters" do
      it "return saved recipe id" do
        user=create(:user)
        recipe=create(:recipe,user:user)
        put save_recipe_url(id: recipe.id), :headers => headers
        expect(response).to have_http_status(:ok)
        expect(RecipeSavedByUser.count).to eq(1)
      end
    end
    context "with invalid parameters" do
      it "return errors when recipe already saved" do
        user=create(:user)
        recipe=create(:recipe,user:user)
        saved=create(:recipe_saved_by_user,user:user,recipe:recipe)
        put save_recipe_url(id: recipe.id), :headers => headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it "return errors when recipe not found" do
        user=create(:user)
        recipe=create(:recipe,user:user)
        saved=create(:recipe_saved_by_user,user:user,recipe:recipe)
        put save_recipe_url(id: recipe.id*2), :headers => headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    context "without auth token given" do
      it "return error message" do
        user=create(:user)
        recipe=create(:recipe,user:user)
        put save_recipe_url(id: recipe.id)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
  
  describe "DELETE /unsave-recipe/:id" do
    headers = {
      "Authorization": "Bearer #{ENV['TEST_TOKEN']}", 
    }
    context "with valid parameters" do
      it "return recipe details" do
        user=create(:user)
        recipe=create(:recipe,user:user)
        saved=create(:recipe_saved_by_user,user:user,recipe:recipe)
        delete save_recipe_url(id: recipe.id), :headers => headers
        expect(response).to have_http_status(:ok)
      end
    end
    context "with invalid parameters" do
      it "return error when recipe not saved by user" do
        user=create(:user)
        recipe=create(:recipe,user:user)
        delete save_recipe_url(id: recipe.id), :headers => headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    context "without auth token given" do
      it "return error message" do
        user=create(:user)
        recipe=create(:recipe,user:user)
        saved=create(:recipe_saved_by_user,user:user,recipe:recipe)
        delete save_recipe_url(id: recipe.id)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
