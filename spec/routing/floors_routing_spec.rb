require "rails_helper"

RSpec.describe FloorsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/floors").to route_to("floors#index")
    end

    it "routes to #new" do
      expect(get: "/floors/new").to route_to("floors#new")
    end

    it "routes to #show" do
      expect(get: "/floors/1").to route_to("floors#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/floors/1/edit").to route_to("floors#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/floors").to route_to("floors#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/floors/1").to route_to("floors#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/floors/1").to route_to("floors#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/floors/1").to route_to("floors#destroy", id: "1")
    end
  end
end
