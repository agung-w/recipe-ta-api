require 'rails_helper'

RSpec.describe User, type: :model do
  context "Name attribute" do
    it "length must be more than 3" do
      user=build(:user,name:"a")
      expect(user).to_not be_valid
    end
    it "must not contain number or special character" do
      user1=build(:user,name:"a321")
      user2=build(:user,name:"a#b")
      expect(user1).to_not be_valid
      expect(user2).to_not be_valid
    end
  end

  context "Email attribute" do
    it "must be in a valid email format" do
      user1=build(:user,email:"test@tes.com")
      user2=build(:user,email:"test@tes")
      expect(user1).to be_valid
      expect(user2).to_not be_valid
    end
    it "must not duplicated" do 
      user1=create(:user,email:"test@tes.com")
      user2=build(:user,email:"test@tes.com")
      expect(user1).to be_valid
      expect(user2).to_not be_valid
    end
  end

  context "Password attribute" do
    it "length must be more than 6" do
      user1=build(:user,password:"123456")
      user2=build(:user,password:"a#b")
      expect(user1).to be_valid
      expect(user2).to_not be_valid
    end
  end

  context "Username attribute" do
    it "must not duplicated" do 
      user1=create(:user,username:"agung")
      user2=build(:user,email:"agung")
      expect(user1).to be_valid
      expect(user2).to_not be_valid
    end
  end

end
