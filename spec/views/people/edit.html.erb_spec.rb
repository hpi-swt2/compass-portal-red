require 'rails_helper'

RSpec.describe "people/edit", type: :view do
  before do
    @person = assign(:person, Person.create!(
                                name: "MyString",
                                surname: "MyString",
                                title: "MyString",
                                email: "MyString",
                                phone: "MyString",
                                office: "MyString",
                                website: "MyString",
                                image: "MyString",
                                chair: "MyString",
                                office_hours: "MyString",
                                telegram_handle: "MyString",
                                knowledge: "MyString"
                              ))
  end

  it "renders the edit person form" do
    render

    assert_select "form[action=?][method=?]", person_path(@person), "post" do

      assert_select "input[name=?]", "person[name]"

      assert_select "input[name=?]", "person[surname]"

      assert_select "input[name=?]", "person[title]"

      assert_select "input[name=?]", "person[email]"

      assert_select "input[name=?]", "person[phone]"

      assert_select "input[name=?]", "person[office]"

      assert_select "input[name=?]", "person[website]"

      assert_select "input[name=?]", "person[image]"

      assert_select "input[name=?]", "person[chair]"

      assert_select "input[name=?]", "person[office_hours]"

      assert_select "input[name=?]", "person[telegram_handle]"

      assert_select "input[name=?]", "person[knowledge]"
    end
  end
end
