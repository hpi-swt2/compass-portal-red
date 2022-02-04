When('I am on the search page') do
  visit search_path
end

When('I navigate to the map page') do
  if page.has_css? "button.navbar-toggler"
    click_button 'toggle-navigation'
  end
  click_button 'Map'
end

Then('I can still see the search query {string} in the search bar') do |string|
  expect(page).to have_field('search', with: string)
end
