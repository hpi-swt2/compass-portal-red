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

  it "renders a list of persons when @query is not empty" do
    FactoryBot.create :person
    FactoryBot.create(:person, first_name: 'Micha', last_name: 'Perscheid', title: 'Not doctor')
    visit "#{search_path}?query=Mich&commit=Search"
    expect(page).to have_link 'Dr. Michael Perscheid'
    expect(page).to have_link 'Not doctor Micha Perscheid'
  end

  it "renders list with rooms containing searched room name" do
    FactoryBot.create :room
    FactoryBot.create(:room, full_name: 'H-E.41')
    visit "#{search_path}?query=H-E&commit=Search"
    expect(page).to have_link 'H-E.41'
    expect(page).to have_link 'H-E.42'
  end

  it "renders list with chairs containing searched chair name" do
    FactoryBot.create :chair
    FactoryBot.create(:chair, name: 'Raumschiff Enterprise')
    visit "#{search_path}?query=Enterprise&commit=Search"
    expect(page).to have_link 'Enterprise Platform and Integration Concepts'
    expect(page).to have_link 'Raumschiff Enterprise'
  end

  it "renders a list containing only attributes searched for" do
    FactoryBot.create :room
    FactoryBot.create :chair
    visit "#{search_path}?query=Enterprise&commit=Search"
    expect(page).not_to have_link 'H-E.42'
  end

end
