require 'rails_helper'

RSpec.describe "people/show", type: :view do
  before do
    @person = assign(:person, Person.create!(
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
                              ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Surname/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Office/)
    expect(rendered).to match(/Website/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/Chair/)
    expect(rendered).to match(/Office Hours/)
    expect(rendered).to match(/Telegram Handle/)
    expect(rendered).to match(/Knowledge/)
  end
end
