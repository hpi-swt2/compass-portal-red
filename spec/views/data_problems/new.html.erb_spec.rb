require 'rails_helper'

RSpec.describe "data_problems/new", type: :view do
  before do
    assign(:data_problem, DataProblem.new(
                            url: "MyString",
                            description: "",
                            field: "MyString",
                            rooms_id: nil,
                            people_id: nil
                          ))
  end

  it "renders new data_problem form" do
    render

    assert_select "form[action=?][method=?]", data_problems_path, "post" do

      assert_select "input[name=?]", "data_problem[url]"

      assert_select "input[name=?]", "data_problem[description]"

      assert_select "input[name=?]", "data_problem[field]"

      assert_select "input[name=?]", "data_problem[rooms_id]"

      assert_select "input[name=?]", "data_problem[people_id]"
    end
  end
end
