require "rails_helper"

RSpec.describe "Search Page", type: :feature do
  context "when loading page it" do
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
  end

  context "when using the search it" do
    it "renders a list of persons when @query is not empty" do
      create :person
      create(:person, first_name: 'Micha', last_name: 'Perscheid', title: 'Not doctor')
      visit "#{search_path}?query=Mich&commit=Search"
      expect(page).to have_link 'Dr. Michael Perscheid'
      expect(page).to have_link 'Not doctor Micha Perscheid'
    end

    it "renders list with rooms containing searched room name" do
      create :room
      create(:room, full_name: 'H-E.41')
      visit "#{search_path}?query=H-E&commit=Search"
      expect(page).to have_link 'H-E.41'
      expect(page).to have_link 'H-E.42'
    end

    it "renders list with chairs containing searched chair name" do
      create :chair
      create(:chair, name: 'Raumschiff Enterprise')
      visit "#{search_path}?query=Enterprise&commit=Search"
      expect(page).to have_link 'Enterprise Platform and Integration Concepts'
      expect(page).to have_link 'Raumschiff Enterprise'
    end

    it "renders list with courses containing searched course name" do
      course1 = create :course
      course2 = create :course, name: 'Scalable Enterprise Software'
      visit "#{search_path}?query=Scalable&commit=Search"
      expect(page).to have_link course1.name
      expect(page).to have_link course2.name
    end

    it "displays icons for search results" do
      create :chair
      visit "#{search_path}?query=Enterprise&commit=Search"
      expect(page).to have_css("//img[@class = 'picture-circle']")
      expect(page).to have_css("img[src*='/assets/placeholder_chair']")
    end

    it "renders a list containing only attributes searched for" do
      create :room
      create :chair
      visit "#{search_path}?query=Enterprise&commit=Search"
      expect(page).not_to have_link 'H-E.42'
    end

    it "displays additional search results based on search" do
      create :chair
      create :room, full_name: 'Office Enterprise'
      visit "#{search_path}?query=Enterprise+Platform&commit=Search"
      expect(page.find('div',  class: 'list-group',
                               text: 'Enterprise Platform and Integration Concepts')[:id]).to eq 'exact-results'
      expect(page.find('div',  class: 'list-group', text: 'Office Enterprise')[:id]).to eq 'similar-results'
    end
  end

  context "when search results have tags it" do
    it "displays tags for room" do
      room = create :room
      visit "#{search_path}?query=#{room.full_name}&commit=Search"
      expect(page).to have_css '.badge'
      expect(page).to have_content room.tags[0].name
    end

    it "displays tags for person" do
      person = create :person
      visit "#{search_path}?query=#{person.name}&commit=Search"
      expect(page).to have_css '.badge'
      expect(page).to have_content person.informations[0].value
    end

    it "displays tags for course" do
      course = create :course
      visit "#{search_path}?query=#{course.name}&commit=Search"
      expect(page).to have_css '.badge'
      expect(page).to have_content course.module_category
    end
  end

  it "doesn't show students as search results if the current user isn't signed in" do
    create :person, status: 'student', first_name: 'john', last_name: 'student'
    visit "#{search_path}?query=john&commit=Search"
    expect(page).not_to have_link 'john student'
  end

  it "shows students as search results if the current user is signed in" do
    user = create :user
    create :person, status: 'student', first_name: 'john', last_name: 'student'
    sign_in user
    visit "#{search_path}?query=john&commit=Search"
    expect(page).to have_link 'john student'
  end
end
