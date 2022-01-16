require 'rails_helper'

RSpec.describe "buildings/show", type: :view do
  let(:building) { FactoryBot.create(:building) }

  before { assign(:building, building) }

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(building.name)
  end

  it "renders a list of the floors that are part of the building" do
    render
    building.floors.each do |floor|
      expect(rendered).to have_link(floor.name, href: floor_path(floor))
    end
  end
end
