require 'rails_helper'

RSpec.describe "options/index", type: :view do

  it "does not render a 'log out' and
  'Edit personal Information' button when signed out" do
    # user_signed_in = false
    render
    expect(rendered).to match("Sign in")
  end
  #   it "renders a 'log out' and 'Edit personal Information' button when signed in" do
  #    current_user = User.create!(
  #         username: "Peter Maffay",
  #         password: "imakeyousexy",
  #         email: "peter.maffay@hpi.de"
  #       )
  #
  #     user_signed_in = true
  #
  #     render
  #     expect(rendered).to match("Log out")
  #     expect(rendered).to match("Edit Personal Information")
  #
  #   end
  #   it "renders a 'Contribute - Solve Data problems' and
  #   'Report a problem' button when signed in as non admin user" do
  #     current_user = User.create!(
  #         username: "Peter Maffay",
  #         isAdmin: false,
  #         password: "imakeyousexy",
  #         email: "peter.maffay@hpi.de"
  #       )
  #
  #    user_signed_in = true
  #
  #     render
  #     expect(rendered).to match("Contribute - Solve Data Problems")
  #     expect(rendered).to match("Report a Problem")
  #
  #   end
  #   it "renders a 'Show data tables' and
  #   'Data management' button when signed in as admin user" do
  #     current_user = User.create!(
  #         username: "Peter Maffay",
  #         isAdmin: true,
  #         password: "imakeyousexy",
  #         email: "peter.maffay@hpi.de"
  #       )
  #
  #     user_signed_in = true
  #
  #     render
  #     expect(rendered).to match("Show data tables")
  #     expect(rendered).to match("Data Management")
  #   end
end
