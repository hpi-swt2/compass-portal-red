require 'rails_helper'

RSpec.describe "data_problems/edit", type: :view do
  let!(:data_problem) do
    assign(:data_problem, DataProblem.create!(
                            url: "MyString",
                            description: "MyString",
                            field: "MyString",
                            room: nil,
                            person: nil
                          ))
  end

  it "renders the edit data_problem form" do
    render

    assert_select "form[action=?][method=?]", data_problem_path(data_problem), "post" do

      assert_select "input[name=?]", "data_problem[url]"

      assert_select "input[name=?]", "data_problem[description]"

      assert_select "input[name=?]", "data_problem[field]"

      assert_select "input[name=?]", "data_problem[room_id]"

      assert_select "input[name=?]", "data_problem[person_id]"
    end
  end
end
