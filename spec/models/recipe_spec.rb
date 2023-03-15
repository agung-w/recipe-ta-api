require 'rails_helper'

RSpec.describe Recipe, type: :model do
  context "attributes vaidation" do
    it "is expected to be valid when given valid values" do
      recipe=build(:recipe)
      expect(recipe).to be_valid
    end

    it "is valid when prep time is nil" do
      recipe=build(:recipe,prep_time:nil)
      expect(recipe).to be_valid
    end

    it "is valid when serving is nil" do
      recipe=build(:recipe,serving:nil)
      expect(recipe).to be_valid
    end

    it "is invalid when title is nil or title length > 100 " do
      recipe=build(:recipe,title:nil)
      expect(recipe).to_not be_valid
      recipe=build(:recipe,title:"a"*101)
      expect(recipe).to_not be_valid
    end

    it "is invalid when description is nil or description length > 1000" do 
      recipe=build(:recipe,description:nil)
      expect(recipe).to_not be_valid
      recipe=build(:recipe,description:"a"*1001)
      expect(recipe).to_not be_valid
    end

    it "is invalid when prep time is nil or is not a number" do
      recipe=build(:recipe,prep_time:"a")
      expect(recipe).to_not be_valid
    end

    it "is invalid when serving is not a number" do
      recipe=build(:recipe,serving:"a")
      expect(recipe).to_not be_valid
    end
    
    it "is invalid when user is nil" do
      recipe=build(:recipe,user:nil)
      expect(recipe).to_not be_valid
    end
  end
end
