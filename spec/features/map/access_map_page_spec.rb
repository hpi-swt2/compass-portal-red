require "rails_helper"

RSpec.describe "Map Page", type: :feature do
  it "exists and renders without error" do
    visit map_path
  end

  it "is accessible through navbar" do
    visit root_path
    expect(page).to have_link(nil, href: map_path)
  end

  it "contains a leaflet container" do
    visit map_path
    expect(page).to have_css '.leaflet'
  end
end
