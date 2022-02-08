require "rails_helper"

RSpec.describe "Map Page", type: :feature do
  it "exists and renders without error" do
    visit map_path
  end

  it "is accessible through navbar" do
    visit root_path
    expect(page).to have_selector(:link_or_button, 'Map')
  end

  it "contains a leaflet container" do
    visit map_path
    expect(page).to have_css '.leaflet'
  end

  it "renders a popup with a link if a room is selected" do
    room = FactoryBot.create :room

    visit map_path(room_id: room.id)

    expect(page).to have_css('.map-popup')
    expect(page).to have_link(href: room_path(room))
  end

  it "renders no popup if no room is selected" do
    visit map_path
    expect(page).to have_no_css('.map-popup')
  end
end
