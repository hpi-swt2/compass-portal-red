require 'rails_helper'

RSpec.describe "point_of_interests/show", type: :view do
  let(:point_of_interest) { FactoryBot.create(:point_of_interest) }

  before { assign(:point_of_interest, point_of_interest) }

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(point_of_interest.description)
  end

  it "shows an image of the point_of_interest if one exists" do
    render
    expect(rendered).to have_css("img[src='#{point_of_interest.image_or_placeholder}']")
  end

  it "shows the placeholder image if no image was linked" do
    assign(:point_of_interest, FactoryBot.create(:point_of_interest, image: ""))
    render
    expect(rendered).to have_css("img[src*=placeholder_poi]")
  end

  it "renders a link to the map page with point_of_interest id as parameter" do
    render
    expect(rendered).to have_link(href: map_path(point_of_interest_id: point_of_interest.point_id))
  end
end
