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

  
end
