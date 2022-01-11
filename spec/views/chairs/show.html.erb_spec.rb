require 'rails_helper'

RSpec.describe "chairs/show", type: :view do
  let(:chair) { FactoryBot.create(:chair) }

  before { assign(:chair, chair) }

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(chair.name)

  end

  it "renders a list of the people that are part of the chair" do
    render
    chair.people.each do |person|
      expect(rendered).to have_link(person.name, href: person_path(person))
      expect(rendered).to have_css("img[src='#{person.image}']")
    end
  end

  it "renders a list of the rooms that are part of the chair" do
    chair.rooms.create(full_name: "HS1", image: "https://via.placeholder.com/150?text=room")
    render
    chair.rooms.each do |room|
      expect(rendered).to have_link(room.full_name, href: room_path(room))
      expect(rendered).to have_css("img[src='#{room.image}']")
    end
  end
end
