require 'rails_helper'

RSpec.describe "courses/new", type: :view do
  before do
    assign(:course, Course.new(
                      name: "MyString",
                      module_category: "MyString"
                    ))
  end

  it "renders new course form" do
    render

    assert_select "form[action=?][method=?]", courses_path, "post" do

      assert_select "input[name=?]", "course[name]"

      assert_select "input[name=?]", "course[module_category]"
    end
  end
end
