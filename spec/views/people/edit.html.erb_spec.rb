require 'rails_helper'

RSpec.describe "people/edit", type: :view do
  let(:person) { FactoryBot.create :person }

  it "renders the edit person form" do
    render
    assert_select "form[action=?][method=?]", person_path(@person), "post" do
      assert_select "input[name=?]", "person[first_name]"
      assert_select "input[name=?]", "person[last_name]"
      assert_select "input[name=?]", "person[title]"
      assert_select "input[name=?]", "person[email]"
      assert_select "input[name=?]", "person[image]"
    end
  end
end
