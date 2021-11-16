require "rails_helper"

RSpec.describe "User login", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  it "prohibits viewing account details when not logged in" do
    visit edit_user_registration_path
    expect(page).to have_css('.alert-danger')
    expect(page).to have_current_path(edit_user_registration_path)
  end

  it "allows viewing account details after login" do
    sign_in user
    visit edit_user_registration_path
    expect(page).not_to have_css('.alert-danger')
    expect(page).to have_current_path(edit_user_registration_path)
  end
end
