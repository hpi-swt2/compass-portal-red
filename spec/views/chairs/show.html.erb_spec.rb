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
    end
  end

  it "renders a list of the rooms that are part of the chair" do
    render
    chair.rooms.each do |room|
      expect(rendered).to have_link(room.name, href: room_path(room))
    end
  end
end
