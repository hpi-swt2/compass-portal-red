require 'rails_helper'

RSpec.describe "buildings/new", type: :view do
  let(:building) { FactoryBot.create(:building) }

  before { assign(:building, building) }

  it "renders new building form" do
    render

    assert_select "form[action=?][method=?]", building_path(building), "post"
  end
end
