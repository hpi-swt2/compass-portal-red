require 'rails_helper'

RSpec.describe "buildings/index", type: :view do
  before do
    assign(:buildings, [
             FactoryBot.create(:building),
             FactoryBot.create(:building)
           ])
  end

  it "renders a list of buildings" do
    render
  end
end
