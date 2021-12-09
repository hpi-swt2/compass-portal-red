require 'rails_helper'

RSpec.describe "people/index", type: :view do
  before do
    assign(:people, [
             Person.create!(
              email: "Email",
              last_name: "Lastname",
              first_name: "Firstname",
              title: "Title",
              image: "Image",
              status: "Xyz"
             ),
             Person.create!(
              email: "Email",
              last_name: "Lastname",
              first_name: "Firstname",
              title: "Title",
              image: "Image",
              status: "Xyz"
             )
           ])
  end

  it "renders a list of people" do
    render
    assert_select "tr>td", text: "Firstname".to_s, count: 2
    assert_select "tr>td", text: "Lastname".to_s, count: 2
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Email".to_s, count: 2
    assert_select "tr>td", text: "Image".to_s, count: 2
    assert_select "tr>td", text: "Xyz".to_s, count: 2
  end
end
