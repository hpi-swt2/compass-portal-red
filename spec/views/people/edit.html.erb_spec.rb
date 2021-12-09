require 'rails_helper'

RSpec.describe "people/edit", type: :view do
  before do
    @person = assign(:person, Person.create!(
                                email: "Email",
                                last_name: "Lastname",
                                first_name: "Firstname",
                                title: "Title",
                                image: "Image",
                                status: "Xyz"
                              ))
  end

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
