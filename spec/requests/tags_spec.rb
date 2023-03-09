require 'rails_helper'

RSpec.describe "Tags", type: :request do
  describe "GET /tag/list" do
    context "get all exisiting tags" do
      it "return list of tags" do
        for i in 1..10 do     
          tag=create(:tag,name:"tag #{i}")
        end
        get tag_list_url
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["data"]["tags"].length).to eq(10)
      end
    end
  end
end
