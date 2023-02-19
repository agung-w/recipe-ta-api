require 'rails_helper'

RSpec.describe User, type: :model do
  context "Name attribute" do
    it "must contain at least 3 char and maximum 60 char" do
      user1=build(:user,name:"abc")
      user2=build(:user,name:"a")
      user3=build(:user,name:"a"*60)
      user4=build(:user,name:"a"*61)
      expect(user1).to be_valid
      expect(user2).to_not be_valid
      expect(user3).to be_valid
      expect(user4).to_not be_valid
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
    it "must contain at least 6 char and maximum 60 char" do
      user1=build(:user,password:"123456")
      user2=build(:user,password:"a#b")
      user3=build(:user,password:"a"*60)
      user4=build(:user,password:"a"*61)
      expect(user1).to be_valid
      expect(user2).to_not be_valid
      expect(user3).to be_valid
      expect(user4).to_not be_valid
    end
  end

  context "Username attribute" do
    it "must not duplicated" do 
      user1=create(:user,username:"agung")
      user2=build(:user,username:"agung")
      expect(user1).to be_valid
      expect(user2).to_not be_valid
    end
    it "must only include letter/number/-/_" do
      user1=create(:user,username:"agung-w1")
      user2=build(:user,username:"agung*")
      expect(user1).to be_valid
      expect(user2).to_not be_valid
    end
    it "must contain at least 3 char and maximum 60 char" do
      user1=build(:user,username:"aaa")
      user2=build(:user,username:"aa")
      user3=build(:user,username:"a"*60)
      user4=build(:user,username:"a"*61)
      expect(user1).to be_valid
      expect(user2).to_not be_valid
      expect(user3).to be_valid
      expect(user4).to_not be_valid
    end
  end

end
