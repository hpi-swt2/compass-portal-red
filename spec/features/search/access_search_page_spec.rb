require "rails_helper"

RSpec.describe "Search Page", type: :feature do
  it "is accessible" do
    visit search_path
  end

  it "is accessible through navbar" do
    visit root_path
    expect(page).to have_link(nil, href: search_path)
  end

  it "contains a search field" do
    visit search_path
    expect(page).to have_field("search")
  end

  it "renders a list when @query is not empty" do
    # This test will fail once the method in the controller is changed or the database changes
    visit "#{search_path}?query=D&commit=Search"
    expect(page).to have_link 'Dan'
    expect(page).to have_link 'Djamal'
    expect(page).to have_link 'Daniel'

  end
end
