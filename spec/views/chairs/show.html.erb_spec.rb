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
end
