require "rails_helper"

RSpec.describe PersonUrlsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/person_urls").to route_to("person_urls#index")
    end

    it "routes to #new" do
      expect(get: "/person_urls/new").to route_to("person_urls#new")
    end

    it "routes to #show" do
      expect(get: "/person_urls/1").to route_to("person_urls#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/person_urls/1/edit").to route_to("person_urls#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/person_urls").to route_to("person_urls#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/person_urls/1").to route_to("person_urls#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/person_urls/1").to route_to("person_urls#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/person_urls/1").to route_to("person_urls#destroy", id: "1")
    end
  end
end
