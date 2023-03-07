require 'rails_helper'

RSpec.describe "Ingredients", type: :request do
  describe "GET /ingredient/find/:query" do
    context "find existing ingredient" do
      it "return ingredient info" do
        ingredient=create(:ingredient,name:"strinG")
        get ingredient_find_url(name: "StRiNg" )
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["data"]["ingredient"]["name"]).to eq("string")
      end
    end
    
    context "find non existing ingredient" do
      it "return ingredient info when parameter is valid" do
        get ingredient_find_url(name: "StRiNg" )
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["data"]["ingredient"]["name"]).to eq("string")
      end
      it "return error status code if name length < 250" do
        get ingredient_find_url(name: "s"*251 )
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["message"]["name"][0]).to eq("is too long (maximum is 250 characters)")
      end
    end

  end
end
