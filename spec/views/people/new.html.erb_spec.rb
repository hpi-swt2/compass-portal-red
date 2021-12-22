require 'rails_helper'

RSpec.describe "people/new", type: :view do
  before do
    assign(:person, Person.new(
                      email: "Email",
                      last_name: "Lastname",
                      first_name: "Firstname",
                      title: "Title",
                      image: "Image",
                      status: "Xyz"
                    ))
  end

  it "renders new person form" do
    render

    assert_select "form[action=?][method=?]", people_path, "post" do
      assert_select "input[name=?]", "person[first_name]"
      assert_select "input[name=?]", "person[last_name]"
      assert_select "input[name=?]", "person[title]"
      assert_select "input[name=?]", "person[email]"
      assert_select "input[name=?]", "person[image]"
      assert_select "input[name=?]", "person[status]"
    end
  end
end
