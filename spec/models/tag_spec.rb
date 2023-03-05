require 'rails_helper'

RSpec.describe Tag, type: :model do
  context "attributes vaidation" do
    it "is expected to be valid when given valid values" do
      tag=build(:tag)
      expect(tag).to be_valid
    end

    it "is invalid when name is nil or name length > 140" do
      tag=build(:tag,name:nil)
      expect(tag).to_not be_valid
      tag=build(:tag,name:"a"*141)
      expect(tag).to_not be_valid
    end
  end
end
