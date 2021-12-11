require 'rails_helper'

RSpec.describe "data_problems/show", type: :view do
  before(:each) do
    @data_problem = assign(:data_problem, DataProblem.create!(
      url: "Url",
      description: "Description",
      field: "Field",
      room: nil,
      person: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Field/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
