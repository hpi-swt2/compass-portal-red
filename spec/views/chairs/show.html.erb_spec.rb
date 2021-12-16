require 'rails_helper'

RSpec.describe "chairs/show", type: :view do
  before do
    @chair = FactoryBot.create :chair
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(@chair.name)
  end
end
