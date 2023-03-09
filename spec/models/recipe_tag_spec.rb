require 'rails_helper'

RSpec.describe RecipeTag, type: :model do
  context "attributes vaidation" do
    it "is expected to be valid when given valid values" do
      recipe_tag=build(:recipe_tag)
      expect(recipe_tag).to be_valid
    end

    it "is expected to be valid when recipe tag is unique" do
      recipe=create(:recipe)
      tag1=create(:tag,name:"tag1")
      tag2=create(:tag,name:"tag2")
      recipe_tag=create(:recipe_tag,recipe:recipe,tag:tag1)
      recipe_tag=build(:recipe_tag,recipe:recipe,tag:tag2)
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

    it "is invalid when recipe tag is duplicated" do
      recipe=create(:recipe)
      tag=create(:tag)
      recipe_tag=create(:recipe_tag,recipe:recipe,tag:tag)
      recipe_tag=build(:recipe_tag,recipe:recipe,tag:tag)
      expect(recipe_tag).to_not be_valid
    end
  end
end
