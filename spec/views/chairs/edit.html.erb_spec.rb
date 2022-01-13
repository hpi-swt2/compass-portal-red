require 'rails_helper'

RSpec.describe "chairs/edit", type: :view do
  let(:chair) { FactoryBot.create(:chair) }

  before { assign(:chair, chair) }

  it "renders the edit chair form" do
    render

    assert_select "form[action=?][method=?]", chair_path(chair), "post"
  end
end
