require 'rails_helper'

describe "map page", type: :feature do
  it "should exist and render without error" do
    visit map_path
  end

  it "should have a leaflet div" do
    visit map_path
	  expect(page).to have_css 'div.leaflet'
  end
end