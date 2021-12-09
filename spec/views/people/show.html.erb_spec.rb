require 'rails_helper'

RSpec.describe "people/show", type: :view do
  before do
    @person = assign(:person, Person.create!(
                                email: "Email",
                                last_name: "Lastname",
                                first_name: "Firstname",
                                title: "Title",
                                image: "Image",
                                status: "Xyz"
                              ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Lastname/)
    expect(rendered).to match(/Firstname/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/Xyz/)
  end
end
