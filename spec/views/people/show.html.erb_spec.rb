require 'rails_helper'

RSpec.describe "people/show", type: :view do
  let(:person) { FactoryBot.create(:person) }

  before { assign(:person, person) }

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(person.email)
    expect(rendered).to have_selector('h1', text: person.full_name)
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
end
