require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  context "attributes vaidation" do
    it "is expected to be valid when given valid values" do
      recipe_ingredient=build(:recipe_ingredient)
      expect(recipe_ingredient).to be_valid
    end

    it "is invalid when name is nil or name length > 250" do
      ingredient=build(:ingredient,name:nil)
      expect(ingredient).to_not be_valid
      ingredient=build(:ingredient,name:"a"*251)
      expect(ingredient).to_not be_valid
    end
  end
end
