require 'rails_helper'

RSpec.describe RecipeComment, type: :model do
  it "is expected to be valid when given valid values" do
    recipe_comment=build(:recipe_comment)
    expect(recipe_comment).to be_valid
  end

  it "is expected to be valid when user comment more than once in single recipe" do
    user=create(:user,username:"tes",email:"tes123@gmail.com")
    recipe=create(:recipe,user:user)
    recipe1=create(:recipe,user:user)
    recipe_comment=create(:recipe_comment,recipe:recipe1)
    recipe_comment=create(:recipe_comment,user:user,recipe:recipe)
    expect(recipe_comment).to be_valid
  end

  it "is expected to be valid if different user comment in the exact same time and recipe" do
    user1=create(:user,username:"user1",email:"user1@gmail.com")
    user2=create(:user,username:"user2",email:"user2@gmail.com")
    recipe=create(:recipe)    
    recipe_comment=create(:recipe_comment,user:user1,recipe:recipe,timestamp:"2023-04-12 22:16:47.8298197")
    recipe_comment=create(:recipe_comment,user:user2,recipe:recipe,timestamp:"2023-04-12 22:16:47.8298197")
    expect(recipe_comment).to be_valid
  end
  
  it "is invalid when the same user comment in the exact same time & recipe" do
    user=create(:user,username:"tes",email:"tes123@gmail.com")
    recipe=create(:recipe)
    recipe_comment=create(:recipe_comment,user:user,recipe:recipe,timestamp:"2023-04-12 22:16:47.8298197")
    recipe_comment=build(:recipe_comment,user:user,recipe:recipe,timestamp:"2023-04-12 22:16:47.8298197")
    expect(recipe_comment).to_not be_valid
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
