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
    FactoryBot.create :person
    FactoryBot.create(:person, first_name: 'Micha', last_name: 'Perscheid', title: 'Not doctor')
    visit "#{search_path}?query=Mich&commit=Search"
    expect(page).to have_link 'Dr. Michael Perscheid'
    expect(page).to have_link 'Not doctor Micha Perscheid'
  end
end
