require "rails_helper"

RSpec.describe DataProblemsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/data_problems").to route_to("data_problems#index")
    end

    it "routes to #new" do
      expect(get: "/data_problems/new").to route_to("data_problems#new")
    end

    it "routes to #show" do
      expect(get: "/data_problems/1").to route_to("data_problems#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/data_problems/1/edit").to route_to("data_problems#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/data_problems").to route_to("data_problems#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/data_problems/1").to route_to("data_problems#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/data_problems/1").to route_to("data_problems#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/data_problems/1").to route_to("data_problems#destroy", id: "1")
    end
  end
end
