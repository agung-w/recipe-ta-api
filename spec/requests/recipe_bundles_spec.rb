require 'rails_helper'

RSpec.describe "RecipeBundles", type: :request do
  describe "GET /recipe-bundles/:id" do
    context "get all recipe bundle" do
      it "return list of recipe bundle" do
        recipe=create(:recipe)
        bundle=create(:recipe_bundle, recipe:recipe)
        get recipe_bundles_url(id: recipe.id)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["data"]["recipe_bundles"].length).to eq(1)
      end
      it "return empty list of recipe bundle when no bundle found" do
        recipe=create(:recipe)
        bundle=build(:recipe_bundle, recipe:recipe)
        get recipe_bundles_url(id: recipe.id)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["data"]["recipe_bundles"].length).to eq(0)
      end
    end
  end
end
