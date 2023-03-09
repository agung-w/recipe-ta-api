require 'rails_helper'

RSpec.describe RecipeSavedByUser, type: :model do
  it "is expected to be valid when given valid values" do
    saved=build(:recipe_saved_by_user)
    expect(saved).to be_valid
  end
  
  it "is valid when the user saves a different recipe" do
    user=create(:user)
    recipe=create(:recipe,user:user)
    recipe1=create(:recipe,user:user)
    saved=create(:recipe_saved_by_user,user:user,recipe:recipe)
    saved=build(:recipe_saved_by_user,user:user,recipe:recipe1)
    expect(saved).to be_valid
  end

  it "is invalid when recipe is nil" do
    saved=build(:recipe_saved_by_user,recipe:nil)
    expect(saved).to_not be_valid
  end

  it "is invalid when user is nil" do
    saved=build(:recipe_saved_by_user,user:nil)
    expect(saved).to_not be_valid
  end

  it "is invalid when recipe saved by user already exist" do
    user=create(:user)
    recipe=create(:recipe,user:user)
    recipe1=create(:recipe,user:user)
    saved=create(:recipe_saved_by_user,user:user,recipe:recipe)
    saved=build(:recipe_saved_by_user,user:user,recipe:recipe)
    expect(saved).to_not be_valid
  end
end
