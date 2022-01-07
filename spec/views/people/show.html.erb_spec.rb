require 'rails_helper'

RSpec.describe "people/show", type: :view do
  let(:person) { FactoryBot.create(:person) }

  before { assign(:person, person) }

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(person.email)
    expect(rendered).to match(person.full_name)
    expect(rendered).to match(person.image)
    expect(rendered).to match(person.status)
  end
end
