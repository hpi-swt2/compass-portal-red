require 'rails_helper'

RSpec.describe "courses/index", type: :view do
  before(:each) do
    assign(:courses, [
      Course.create!(
        name: "Name",
        module_category: "Module Category"
      ),
      Course.create!(
        name: "Name",
        module_category: "Module Category"
      )
    ])
  end

  it "renders a list of courses" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Module Category".to_s, count: 2
  end
end
