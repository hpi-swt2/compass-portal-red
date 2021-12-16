require 'rails_helper'

RSpec.describe "rooms/show", type: :view do
  before do
    @room = FactoryBot.create :room
    # @building = FactoryBot.create :building
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(@room.number)
    expect(rendered).to match(@room.floor)
    expect(rendered).to match(@room.full_name)
  end
  it "renders a list of its tags" do
    render
    @room.tags.each do |tag|
      expect(rendered).to match(tag.name)
    end
  end
  it "renders a list of its room types" do
    render
    @room.room_types.each do |room_type|
      expect(rendered).to match(room_type.name)
    end
  end
  it "renders a list of the chairs it belongs to" do
    render
    @room.chairs.each do |chair|
      expect(rendered).to match(chair.name)
      expect(rendered).to have_link(nil, href: chair_path(chair))
    end
  end
  it "renders a list of the people that use the room" do
    render
    puts
    @room.people.each do |person|
      puts person_path(person)
      puts @room.people.length
      expect(rendered).to match(person.name)
      expect(rendered).to have_link(nil, href: person_path(person))
      puts person.full_name
    end
  end
  # it "has a link to its building" do
  #   render
  #   expect(rendered).to have_link(nil, href: show_building_path(@building))
  # end
end
