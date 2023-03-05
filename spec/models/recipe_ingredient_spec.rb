require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  context "attributes vaidation" do
    it "is expected to be valid when given valid values" do
      recipe_ingredient=build(:recipe_ingredient)
      expect(recipe_ingredient).to be_valid
    end
    it "is valid when metric is nil" do
      recipe_ingredient=build(:recipe_ingredient,metric:nil)
      expect(recipe_ingredient).to be_valid
    end
    it "is valid when quantity is nil" do
      recipe_ingredient=build(:recipe_ingredient,quantity:nil)
      expect(recipe_ingredient).to be_valid
    end

    it "is invalid when recipe is nil" do
      recipe_ingredient=build(:recipe_ingredient,recipe:nil)
      expect(recipe_ingredient).to_not be_valid
    end

    it "is invalid when ingredient is nil" do
      recipe_ingredient=build(:recipe_ingredient,ingredient:nil)
      expect(recipe_ingredient).to_not be_valid
    end
  end
end
