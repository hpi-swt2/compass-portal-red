require "rails_helper"

RSpec.describe BuildingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/buildings").to route_to("buildings#index")
    end

    it "routes to #new" do
      expect(get: "/buildings/new").to route_to("buildings#new")
    end

    it "routes to #show" do
      expect(get: "/buildings/1").to route_to("buildings#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/buildings/1/edit").to route_to("buildings#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/buildings").to route_to("buildings#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/buildings/1").to route_to("buildings#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/buildings/1").to route_to("buildings#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/buildings/1").to route_to("buildings#destroy", id: "1")
    end
  end
end
