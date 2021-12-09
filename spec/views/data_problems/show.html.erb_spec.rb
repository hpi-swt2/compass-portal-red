require 'rails_helper'

RSpec.describe "data_problems/show", type: :view do
  before(:each) do
    @data_problem = assign(:data_problem, DataProblem.create!(
      url: "Url",
      description: "Test",
      field: "Field",
      rooms_id: nil,
      people_id: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/Test/)
    expect(rendered).to match(/Field/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
