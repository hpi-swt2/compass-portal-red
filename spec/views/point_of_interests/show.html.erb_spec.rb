require 'rails_helper'

RSpec.describe "point_of_interests/show", type: :view do
  let(:point_of_interest) { FactoryBot.create(:point_of_interest) }

  before { assign(:point_of_interest, point_of_interest) }

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(point_of_interest.name)
    expect(rendered).to match(point_of_interest.description)
  end

  it "shows an image of the point_of_interest if one exists" do
    render
    expect(rendered).to match(url_for(point_of_interest.image))
  end

  it "shows the placeholder image if no image was linked" do
    point_of_interest.image.purge
    render
    expect(rendered).to have_css("img[src*=placeholder_poi]")
  end

  it "renders a link to the map page with point id as parameter" do
    render
    expect(rendered).to have_link(href: map_path(point_of_interest_id: point_of_interest.point_id))
  end
end
