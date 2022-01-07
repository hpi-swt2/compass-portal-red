require 'rails_helper'

RSpec.describe "people/show", type: :view do
  let(:person) { FactoryBot.create(:person) }

  before { assign(:person, person) }

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(person.email)
    expect(rendered).to match(person.first_name)
    expect(rendered).to match(person.last_name)
    expect(rendered).to match(person.title)
    expect(rendered).to match(person.image)
    expect(rendered).to match(person.status)
  end
end
