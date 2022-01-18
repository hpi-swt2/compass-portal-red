require 'rails_helper'

RSpec.describe "floors/edit", type: :view do
  let(:floor) { FactoryBot.create(:floor) }

  before { assign(:floor, floor) }

  it "renders the edit floor form" do
    render

    assert_select "form[action=?][method=?]", floor_path(floor), "post"
  end
end
