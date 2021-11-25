require "rails_helper"

RSpec.describe "Map Page", type: :feature do
  it "is accessible" do
    visit map_path
  end

  it "is accessible through navbar" do
    visit root_path
    expect(page).to have_link(nil, href: map_path)
  end

  it "it contains a map container" do
    visit map_path
    expect(page).to have_css('.map')
  end
end