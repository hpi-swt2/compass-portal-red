require 'rails_helper'

RSpec.describe "people/index", type: :view do
  let(:people) { FactoryBot.create_list(:person, 2) }

  before { assign(:people, people) }

  it "renders a list of people" do
    render
    person = people[0]
    assert_select "tr>td", text: person.first_name, count: 2
    assert_select "tr>td", text: person.last_name, count: 2
    assert_select "tr>td", text: person.title, count: 2
    assert_select "tr>td", text: person.email.gsub('@', '(at)'), count: 2
    assert_select "tr>td", text: person.status, count: 2
  end
end
