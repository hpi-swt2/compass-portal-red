require 'rails_helper'

RSpec.describe "chairs/index", type: :view do
  before do
    assign(:chairs, [
             FactoryBot.create(:chair),
             FactoryBot.create(:chair)
           ])
  end

  it "renders a list of chairs" do
    render
  end
end
