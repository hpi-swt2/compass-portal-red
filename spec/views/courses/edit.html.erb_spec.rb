require 'rails_helper'

RSpec.describe "courses/edit", type: :view do
  let(:course) { create(:course) }

  it "renders the edit course form" do
    render

    assert_select "form[action=?][method=?]", course_path(course), "post" do

      assert_select "input[name=?]", "course[name]"

      assert_select "input[name=?]", "course[module_category]"
    end
  end
end
