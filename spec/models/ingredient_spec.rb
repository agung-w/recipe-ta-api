require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  context "attributes vaidation" do
    it "is expected to be valid when given valid values" do
      ingredient=create(:ingredient)
      expect(ingredient).to be_valid
      expect(ingredient.name).to eq("mystring")
    end

    it "is invalid when name is nil or name length > 250" do
      ingredient=build(:ingredient,name:nil)
      expect(ingredient).to_not be_valid
      ingredient=build(:ingredient,name:"a"*251)
      expect(ingredient).to_not be_valid
    end
  end
end
