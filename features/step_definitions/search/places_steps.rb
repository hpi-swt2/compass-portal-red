When('I am on the search page') do
  visit search_path
end

When('I navigate to the map page') do
  click_button 'Map'
end

Then('I can still see the search query {string} in the search bar') do |string|
  expect(page).to have_field('search', with: string)
end
