require 'rails_helper'

RSpec.describe RecipeComment, type: :model do
  it "is expected to be valid when given valid values" do
    recipe_comment=build(:recipe_comment)
    expect(recipe_comment).to be_valid
  end

  it "is expected to be valid when user comment more than once in single recipe" do
    user=create(:user)
    recipe=create(:recipe,user:user)
    recipe_comment=create(:recipe_comment,user:user,recipe:recipe)
    recipe_comment=create(:recipe_comment,user:user,recipe:recipe)
    expect(recipe_comment).to be_valid
  end

  it "is invalid when recipe is nil" do
    recipe_comment=build(:recipe_comment,recipe:nil)
    expect(recipe_comment).to_not be_valid
  end

  it "is invalid when user is nil" do
    recipe_comment=build(:recipe_comment,user:nil)
    expect(recipe_comment).to_not be_valid
  end

  it "is invalid when content length is < 1 or >3000" do
    recipe_comment=build(:recipe_comment,content:"")
    expect(recipe_comment).to_not be_valid
    recipe_comment=build(:recipe_comment,content:"a"*3001)
    expect(recipe_comment).to_not be_valid
  end

  it "is invalid when content is nil" do
    recipe_comment=build(:recipe_comment,content:nil)
    expect(recipe_comment).to_not be_valid
  end
end
