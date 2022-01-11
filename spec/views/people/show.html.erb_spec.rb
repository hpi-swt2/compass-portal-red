require 'rails_helper'

RSpec.describe "people/show", type: :view do
  let(:person) { FactoryBot.create(:person) }

  before { assign(:person, person) }

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(person.email)
    expect(rendered).to match(person.full_name)
    expect(rendered).to match(person.image)
    expect(rendered).to match(person.status)
  end

  it "shows an image of the person if one exists" do
    render
    expect(rendered).to have_css("img[src='#{person.image}']")
  end

  it "shows the placeholder image if no image was linked" do
    assign(:person, FactoryBot.create(:person, image: ""))
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
