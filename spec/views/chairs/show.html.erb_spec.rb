require 'rails_helper'

RSpec.describe "chairs/show", type: :view do
  before do
    @chair = FactoryBot.create :chair
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(@chair.name)

  end
  it "renders a list of the people that use the room" do
    render
    @room.people.each do |person|
      expect(rendered).to have_link(person.name, href: person_path(person))
    end
  end
end
