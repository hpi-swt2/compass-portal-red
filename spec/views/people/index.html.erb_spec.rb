require 'rails_helper'

RSpec.describe "people/index", type: :view do
  before(:each) do
    assign(:people, [
      Person.create!(
        name: "Name",
        surname: "Surname",
        title: "Title",
        email: "Email",
        phone: "Phone",
        office: "Office",
        website: "Website",
        image: "Image",
        chair: "Chair",
        office_hours: "Office Hours",
        telegram_handle: "Telegram Handle",
        knowledge: "Knowledge"
      ),
      Person.create!(
        name: "Name",
        surname: "Surname",
        title: "Title",
        email: "Email",
        phone: "Phone",
        office: "Office",
        website: "Website",
        image: "Image",
        chair: "Chair",
        office_hours: "Office Hours",
        telegram_handle: "Telegram Handle",
        knowledge: "Knowledge"
      )
    ])
  end

  it "renders a list of people" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Surname".to_s, count: 2
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Email".to_s, count: 2
    assert_select "tr>td", text: "Phone".to_s, count: 2
    assert_select "tr>td", text: "Office".to_s, count: 2
    assert_select "tr>td", text: "Website".to_s, count: 2
    assert_select "tr>td", text: "Image".to_s, count: 2
    assert_select "tr>td", text: "Chair".to_s, count: 2
    assert_select "tr>td", text: "Office Hours".to_s, count: 2
    assert_select "tr>td", text: "Telegram Handle".to_s, count: 2
    assert_select "tr>td", text: "Knowledge".to_s, count: 2
  end
end
