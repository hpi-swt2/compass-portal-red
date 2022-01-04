require "rails_helper"
require "nokogiri"

RSpec.describe "Indoor Upload Page", type: :feature do
  before do
    visit indoor_upload_path
  end

  it "renders correct title" do
    expect(page).to have_text("Import indoor map")
  end

  it "has a file input field" do
    expect(page).to have_field('file')
  end

  it "accepts file input" do
    expect(Room.where(full_name: 'HS 2')).not_to exist

    find('form input[type="file"]').set('app/assets/data/importBuilding1.gpx')
    find('input[type="submit"]').click

    expect(Room.where(full_name: 'HS 2')).to exist
  end
end
