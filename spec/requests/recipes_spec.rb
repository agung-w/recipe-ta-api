require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  describe "POST /create" do
    let(:valid_request_body) {
      user=create(:user)
      ingredient1=create(:ingredient,name:"wortel")
      ingredient2=create(:ingredient,name:"ayam")
      metric=create(:metric)
      tag=create(:tag)
      {
        "title" => "Recipe Test",
        "description" => "test",
        "prep_time" => 10,
        "serving" => 2,
        "recipe_ingredients_attributes"=>[
          {
            "ingredient_id"=>ingredient1.id,
            "quantity"=>1,
            "metric_id"=>metric.id
          },
          {
            "ingredient_id"=>ingredient2.id,
            "quantity"=>1,
            "metric_id"=>metric.id
          },
        ],
        "cooking_steps_attributes"=>[
          {
            "step"=>1,
            "description"=>"Test",
            "pic_url"=>"tes.com"
          },
          {
            "step"=>2,
            "description"=>"Test123",
            "pic_url"=>"tes.com"
          }
        ],
        "recipe_tags_attributes"=>[
          {
            "tag_id"=>tag.id
          }
        ]
      }
    }
    context "valid request" do
      it "return success message and its status code" do
        headers = {
          "Authorization": "Bearer #{ENV['TEST_TOKEN']}", 
        }
        expect{
          post recipe_create_url, params: { recipe: valid_request_body}, :headers => headers
        }.to change(Recipe, :count).by(1)
        
        expect(Recipe.first.title).to eq("Recipe Test")
        expect(Recipe.first.recipe_ingredients.first.ingredient.name).to eq("wortel")
        expect(Recipe.first.recipe_ingredients[1].ingredient.name).to eq("ayam")
      end
    end
  end

  describe "GET /recipe/:id" do
    headers = {
      "Authorization": "Bearer #{ENV['TEST_TOKEN']}", 
    }
    context "with valid parameters" do
      it "return recipe details" do
        recipe=create(:recipe)
        get recipe_url(id: recipe.id ), :headers => headers
        expect(response).to have_http_status(:ok)
      end
    end
    context "with invalid parameters" do
      it "return error message" do
        recipe=create(:recipe)
        get recipe_url(id: recipe.id*2 ), :headers => headers
        expect(response).to have_http_status(:not_found)
      end
    end
    context "without auth token given" do
      it "return error message" do
        recipe=create(:recipe)
        get recipe_url(id: recipe.id )
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
  
  describe "GET /recipe/search/:query" do
    context "with valid parameters" do
      it "return recipe list" do
        recipe=create(:recipe,title:"MyString")
        get recipe_search_url(query: "string" )
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["data"]["recipes"][0]["title"]).to eq("MyString")
        expect(JSON.parse(response.body)["data"]["recipes"].length).to eq(1)
      end
    end
    context "query not found" do
      it "return status ok and blank recipe list" do
        recipe=create(:recipe,title:"MyString")
        get recipe_search_url(query: "djaksdmkalsdnas" )
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["data"]["recipe"]).to be_blank
      end
    end

  end
end
