When('I am on the search page') do
  visit search_path
end

When('I am on the map page') do
  visit map_path
end

When('I navigate to the {string} page') do |string|
  click_button 'toggle-navigation' if page.has_css? "button.navbar-toggler"
  click_button string
end

Then('I can still see the search query {string} in the search bar') do |string|
  expect(page).to have_field('search', with: string)
end
