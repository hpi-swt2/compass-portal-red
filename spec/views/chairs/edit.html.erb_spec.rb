require 'rails_helper'

RSpec.describe "chairs/edit", type: :view do
  before(:each) do
    @chair = assign(:chair, Chair.create!())
  end

  it "renders the edit chair form" do
    render

    assert_select "form[action=?][method=?]", chair_path(@chair), "post" do
    end
  end
end
