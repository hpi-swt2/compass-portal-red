require 'rails_helper'

RSpec.describe "rooms/show", type: :view do
  let(:room) { FactoryBot.create(:room) }

  before { assign(:room, room) }

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(room.number)
    expect(rendered).to match(room.floor)
    expect(rendered).to match(room.full_name)
  end

  it "renders a list of its tags" do
    render
    room.tags.each do |tag|
      expect(rendered).to match(tag.name)
    end
  end

  it "renders a list of its room types" do
    render
    room.room_types.each do |room_type|
      expect(rendered).to match(room_type.name)
    end
  end

  it "renders a list of the chairs it belongs to" do
    render
    room.chairs.each do |chair|
      expect(rendered).to have_link(chair.name, href: chair_path(chair))
    end
  end

  it "renders a list of the people that use the room" do
    # byebug
    render
    room.people.each do |person|
      expect(rendered).to have_link(person.name, href: person_path(person))
    end
  end
end
