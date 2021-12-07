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

    it "response with JSON body containing correct attributes" do
      body = nil
      expect { body = JSON.parse(response.body).with_indifferent_access }.not_to raise_exception
      expect(body.keys).to match_array(%w[type features])
    end

    it "response with JSON body containing a correct number of features" do
      body = JSON.parse(response.body).with_indifferent_access
      expect(body["features"].length).to eq(6)
    end
  end
end
