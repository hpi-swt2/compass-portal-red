require 'rails_helper'

RSpec.describe "floors/new", type: :view do
  let(:floor) { FactoryBot.create(:floor) }

  before { assign(:floor, floor) }

  it "renders new floor form" do
    render

    assert_select "form[action=?][method=?]", floor_path(floor), "post"
  end
end
