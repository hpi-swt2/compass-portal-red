When('I start the search') do
  page.find_button('Search').click
end

When('I enter {string}') do |string|
  fill_in 'query', with: string
end

Then('I see the search result {string}') do |string|
  expect(page).to have_content(string)
end

Then('I see next to the search result an icon for a {string}') do |string|
  element = page.find('i')
  expect(element['class']).to match("search-item-icon --#{string}")
end
