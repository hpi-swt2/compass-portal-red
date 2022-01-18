require 'rails_helper'

RSpec.describe "people/show", type: :view do
  let(:person) { FactoryBot.create(:person) }

  before { assign(:person, person) }

  it "renders attributes in <p>" do
    render
    expect(rendered).to include(person.email.gsub('@', '(at)')) # The @ is replaced with (at) on frontend
    expect(rendered).to have_selector('h1', text: person.full_name)
    expect(rendered).to match(url_for(person.image))
    expect(rendered).to match(person.status)
  end

  it "shows an image of the person if one exists" do
    render
    expect(rendered).to match(url_for(person.image))
  end

  it "shows the placeholder image if no image was linked" do
    person.image.purge
    render
    expect(rendered).to have_css("img[src*=placeholder_person]")
  end

  it "shows details of an existing room" do
    person.create_room(full_name: "HS1")
    render
    expect(rendered).to match(person.room.full_name)
    expect(rendered).to have_css("img[src*='placeholder_room']")
  end
end
