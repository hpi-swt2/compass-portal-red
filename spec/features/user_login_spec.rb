require "rails_helper"

RSpec.feature "User details", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario "are not viewable before login" do
    visit edit_user_registration_path
    expect(page).to have_css('.alert-danger')
    expect(page).to_not have_current_path(edit_user_registration_path)
  end

  scenario "are viewable after login" do
    sign_in user
    visit edit_user_registration_path
    expect(page).to_not have_css('.alert-danger')
    expect(page).to have_current_path(edit_user_registration_path)
  end
end