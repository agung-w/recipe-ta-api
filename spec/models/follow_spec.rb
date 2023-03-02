require 'rails_helper'

RSpec.describe Follow, type: :model do
  context "valid cases" do
    it "is valid to follow another user" do
      user1=create(:user)
      user2=create(:user,email:"a"+user1.email,username:user1.username*2)
      follow=build(:follow , user:user1,followed:user2)
      expect(follow).to be_valid
    end
    it "is valid to follow followers" do
      user1=create(:user)
      user2=create(:user,email:"a"+user1.email,username:user1.username*2)
      follow=create(:follow , user:user1,followed:user2)
      follow=build(:follow , user:user2,followed:user1)

      expect(follow).to be_valid
    end
  end
  context "invalid cases" do
    it "is invalid to follow followed user" do
      user1=create(:user)
      user2=create(:user,email:"a"+user1.email,username:user1.username*2)
      follow1=create(:follow , user:user1,followed:user2)
      follow2=build(:follow , user:user1,followed:user2)
      follow3=create(:follow , user:user2,followed:user1)
      follow4=build(:follow , user:user2,followed:user1)
      expect(follow1).to be_valid
      expect(follow2).to_not be_valid
      expect(follow3).to be_valid
      expect(follow4).to_not be_valid
    end
    it "is invalid to follow unregistered user" do
      user1=create(:user)
      follow=build(:follow , user:user1, followed:nil)
      expect(follow).to_not be_valid
    end
    
    it "is invalid to follow user itself" do
      user1=create(:user)
      follow=build(:follow, user:user1, followed:user1)
      expect(follow).to_not be_valid
    end
  end
end
