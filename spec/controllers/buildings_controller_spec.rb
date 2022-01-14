require 'rails_helper'

RSpec.describe BuildingsController, type: :controller do
  describe "GET" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
