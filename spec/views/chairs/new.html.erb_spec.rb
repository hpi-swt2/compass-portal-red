require 'rails_helper'

RSpec.describe "chairs/new", type: :view do
  let(:chair) { FactoryBot.create :chair }

  it "renders new chair form" do
    render

    assert_select "form[action=?][method=?]", chairs_path, "post"
  end
end
