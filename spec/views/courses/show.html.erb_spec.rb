require 'rails_helper'

RSpec.describe "courses/show", type: :view do
  before do
    @course = assign(:course, Course.create!(
                                name: "Name",
                                module_category: "Module Category"
                              ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Module Category/)
  end
end
