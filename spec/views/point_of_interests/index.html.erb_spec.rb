require 'rails_helper'

RSpec.describe "point_of_interests/index", type: :view do
  let(:point_of_interests) { FactoryBot.create_list(:point_of_interest, 2) }

  before do
    assign(:point_of_interests, point_of_interests)
  end

  it "renders a list of point_of_interests" do
    render
  end
end
