require 'rails_helper'

RSpec.describe RecipeBundle, type: :model do
  it "is expected to be valid when given valid values" do
    recipe=build(:recipe)
    bundle=build(:recipe_bundle,recipe:recipe)
    expect(bundle).to be_valid
  end

  it "stock can be 0" do
    recipe=build(:recipe)
    bundle=build(:recipe_bundle,stock:0,recipe:recipe)
    expect(bundle).to be_valid
  end
  it "stock cant be negative" do
    recipe=build(:recipe)
    bundle=build(:recipe_bundle,stock:-1,recipe:recipe)
    expect(bundle).to_not be_valid
  end
  it "stock cant be null" do
    recipe=build(:recipe)
    bundle=build(:recipe_bundle,stock:nil,recipe:recipe)
    expect(bundle).to_not be_valid
  end

  it "title cant be null " do
    recipe=build(:recipe)
    bundle=build(:recipe_bundle,title:nil,recipe:recipe)
    expect(bundle).to_not be_valid
  end

  it "description cant be null " do
    recipe=build(:recipe)
    bundle=build(:recipe_bundle,description:nil,recipe:recipe)
    expect(bundle).to_not be_valid
  end

  it "price cant be null" do
    recipe=build(:recipe)
    bundle=build(:recipe_bundle,price:-1,recipe:recipe)
    expect(bundle).to_not be_valid
  end

  it "price cant be negative" do
    recipe=build(:recipe)
    bundle=build(:recipe_bundle,price:-1,recipe:recipe)
    expect(bundle).to_not be_valid
  end
end
