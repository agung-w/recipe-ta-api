require 'rails_helper'

RSpec.describe RecipeTag, type: :model do
  context "attributes vaidation" do
    it "is expected to be valid when given valid values" do
      recipe_tag=build(:recipe_tag)
      expect(recipe_tag).to be_valid
    end

    it "is invalid when recipe is nil" do
      recipe_tag=build(:recipe_tag,recipe:nil)
      expect(recipe_tag).to_not be_valid
    end

    it "is invalid when tag is nil" do
      recipe_tag=build(:recipe_tag,tag:nil)
      expect(recipe_tag).to_not be_valid
    end
  end
end
