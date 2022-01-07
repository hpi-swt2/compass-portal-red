require 'rails_helper'

RSpec.describe "people/new", type: :view do
  let(:person) { FactoryBot.create(:person) }

  before { assign(:person, person) }

  it "renders new person form" do
    render

    assert_select "form[action=?][method=?]", person_path(person), "post" do
      assert_select "input[name=?]", "person[first_name]"
      assert_select "input[name=?]", "person[last_name]"
      assert_select "input[name=?]", "person[title]"
      assert_select "input[name=?]", "person[email]"
      assert_select "input[name=?]", "person[image]"
      assert_select "input[name=?]", "person[status]"
    end
  end
end
