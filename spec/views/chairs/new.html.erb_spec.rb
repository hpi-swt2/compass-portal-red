require 'rails_helper'

RSpec.describe "chairs/new", type: :view do
  before do
    assign(:chair, Chair.new)
  end

  it "renders new chair form" do
    render

    assert_select "form[action=?][method=?]", chairs_path, "post" do
    end
  end
end
