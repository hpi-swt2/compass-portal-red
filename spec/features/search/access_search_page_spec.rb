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

  it "displays icons for search results" do
    FactoryBot.create :chair
    visit "#{search_path}?query=Enterprise&commit=Search"
    expect(page).to have_css("//img[@class = 'picture-rounded md']")
    expect(page).to have_css("img[src*='/assets/placeholder_chair']")
  end

  it "displays tags for search results" do
    FactoryBot.create :room
    visit "#{search_path}?query=H-E&commit=Search"
    expect(page).to have_css '.badge'
    expect(page).to have_content 'lecture hall'
  end

  it "displays additional search results based on search" do
    FactoryBot.create :chair
    FactoryBot.create :room, full_name: 'Office Enterprise'
    visit "#{search_path}?query=Enterprise+Platform&commit=Search"
    expect(page.find('div',  class: 'list-group',
                             text: 'Enterprise Platform and Integration Concepts')[:id]).to eq 'exact-results'
    expect(page.find('div',  class: 'list-group', text: 'Office Enterprise')[:id]).to eq 'similar-results'
  end

  it "doesn't show students as search results if the current user isn't signed in" do
    FactoryBot.create :person, role: 'student'
    visit "#{search_path}?query=Mich&commit=Search"
    expect(page).not_to have_link 'Michael Perscheid'
  end

  it "shows students as search results if the current user is signed in" do
    user = FactoryBot.create :user
    FactoryBot.create :person, role: 'student'
    sign_in user
    visit "#{search_path}?query=Mich&commit=Search"
    expect(page).to have_link 'Michael Perscheid'
  end
end
