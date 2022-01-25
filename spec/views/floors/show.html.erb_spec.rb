require 'rails_helper'

RSpec.describe "floors/show", type: :view do
  let(:floor) { FactoryBot.create(:floor) }

  before { assign(:floor, floor) }

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(floor.name)
  end

  it "renders a list of the rooms that are part of the floor" do
    render
    floor.rooms.each do |room|
      expect(rendered).to have_link(room.name, href: room_path(room))
    end
  end
end
