require 'rails_helper'

RSpec.describe "data_problems/edit", type: :view do
  before(:each) do
    @data_problem = assign(:data_problem, DataProblem.create!(
      url: "MyString",
      description: "",
      field: "MyString",
      rooms_id: nil,
      people_id: nil
    ))
  end

  it "renders the edit data_problem form" do
    render

    assert_select "form[action=?][method=?]", data_problem_path(@data_problem), "post" do

      assert_select "input[name=?]", "data_problem[url]"

      assert_select "input[name=?]", "data_problem[description]"

      assert_select "input[name=?]", "data_problem[field]"

      assert_select "input[name=?]", "data_problem[rooms_id]"

      assert_select "input[name=?]", "data_problem[people_id]"
    end
  end
end
