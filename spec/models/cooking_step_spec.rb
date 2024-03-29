require 'rails_helper'

RSpec.describe CookingStep, type: :model do
  context "attributes vaidation" do
    it "is expected to be valid when given valid values" do
      cooking_step=build(:cooking_step)
      expect(cooking_step).to be_valid
    end

    it "is valid when step is not duplicated" do
      recipe=create(:recipe)
      cooking_step=create(:cooking_step,recipe:recipe,step:1)
      cooking_step=build(:cooking_step,recipe:recipe,step:2)
      expect(cooking_step).to be_valid
    end
    
    it "is valid when pic_url is nil" do
      cooking_step=build(:cooking_step,pic_url:nil)
      expect(cooking_step).to be_valid
    end

    it "is invalid when recipe is nil" do
      cooking_step=build(:cooking_step,recipe:nil)
      expect(cooking_step).to_not be_valid
    end

    it "is invalid when step is nil" do
      cooking_step=build(:cooking_step,step:nil)
      expect(cooking_step).to_not be_valid
    end

    it "is invalid when step is duplicated" do
      recipe=create(:recipe)
      cooking_step=create(:cooking_step,recipe:recipe)
      cooking_step=build(:cooking_step,recipe:recipe)
      expect(cooking_step).to_not be_valid
    end

    it "is invalid when description is nil or description length > 1000" do
      cooking_step=build(:cooking_step,description:nil)
      expect(cooking_step).to_not be_valid
      cooking_step=build(:cooking_step,description:"a"*1001)
      expect(cooking_step).to_not be_valid
    end
  end
end
