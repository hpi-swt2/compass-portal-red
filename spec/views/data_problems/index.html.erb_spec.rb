require 'rails_helper'

RSpec.describe "data_problems/index", type: :view do
  before do
    assign(:data_problems, [
             DataProblem.create!(
               url: "Url",
               description: "Description",
               field: "Field",
               room: nil,
               person: nil
             ),
             DataProblem.create!(
               url: "Url",
               description: "Description",
               field: "Field",
               room: nil,
               person: nil
             )
           ])
  end

  it "renders a list of data_problems" do
    render
    assert_select "tr>td", text: "Url".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: "Field".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 4
  end
end
