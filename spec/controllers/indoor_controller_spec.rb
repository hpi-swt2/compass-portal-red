require 'rails_helper'

RSpec.describe IndoorController, type: :controller do
  describe "GET #json" do
    before do
      create :building
      get :geojson
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "responds with valid JSON body" do
      expect { JSON.parse(response.body).with_indifferent_access }.not_to raise_exception
    end

    context "when responding with valid JSON body" do
      let(:body) { JSON.parse(response.body).with_indifferent_access }

      it "contains correct attributes" do
        expect(body.keys).to match_array(%w[type features])
      end

      it "contains a correct number of features" do
        expect(body["features"].length).to eq(0)
      end
    end
  end
end
