require "rails_helper"

RSpec.describe "Map Page", type: :feature do
  it "should exist and render without error" do
    visit map_path
  end

  it "should be accessible through navbar" do
    visit root_path
    expect(page).to have_link(nil, href: map_path)
  end

  it "should contain a leaflet container" do
    visit map_path
    expect(page).to have_css '.leaflet'
  end
end
