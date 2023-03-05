require 'rails_helper'

RSpec.describe Metric, type: :model do
  context "attributes vaidation" do
    it "is expected to be valid when given valid values" do
      metric=build(:metric)
      expect(metric).to be_valid
    end

    it "is invalid when name is nil or name length > 100" do\
      metric=build(:metric,name:nil)
      expect(metric).to_not be_valid
      metric=build(:metric,name:"a"*101)
      expect(metric).to_not be_valid
    end

    it "is invalid when abbrev is nil or name length > 6" do
      metric=build(:metric,abbrev:nil)
      expect(metric).to_not be_valid
      metric=build(:metric,abbrev:"a"*7)
      expect(metric).to_not be_valid
    end

    it "is invalid when volume is not nil or a number" do
      metric=build(:metric,volume:"a")
      expect(metric).to_not be_valid
    end

    it "is invalid when weight is not a number" do
      metric=build(:metric,weight:"a")
      expect(metric).to_not be_valid
    end
  end
end
