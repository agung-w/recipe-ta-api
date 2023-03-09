require 'rails_helper'

RSpec.describe "Metrics", type: :request do
  describe "GET /metric/list" do
    context "get all exisiting metrics" do
      it "return list of metrics" do
        for i in 1..10 do     
          metric=create(:metric,name:"metric #{i}")
        end
        get metric_list_url
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["data"]["metrics"].length).to eq(10)
      end
    end
  end
end
