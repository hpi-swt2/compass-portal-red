require "rails_helper"

RSpec.describe "Search Page", type: :feature do
  it "is accessible" do
    visit search_path
  end

  it "is accessible through navbar" do
    visit root_path
    expect(page).to have_link(nil, href: search_path)
  end

  it "it contains a search field" do
    visit search_path
    expect(page).to have_field("search")
  end
end