require 'rails_helper'

RSpec.describe "floors/index", type: :view do
  before do
    assign(:floors, [
             FactoryBot.create(:floor),
             FactoryBot.create(:floor)
           ])
  end

  it "renders a list of floors" do
    render
  end
end
