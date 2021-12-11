def create_person
  Person.create(first_name: 'Michael', last_name: 'Perscheid', title: 'Dr')
end

Given 'a person was created' do
  create_person
end

Given('I am on the home page') do
  visit search_path
  puts Person.first.first_name
end

Given('I start the search') do
  page.find_button('Search').click
end

Given('I enter {string}') do |string|
  fill_in 'query', with: string
end

Then('I see the search result {string}') do |string|
  expect(page).to have_content(string)
end

Then('I see next to the search result an icon for a {string}') do |string|
  element = page.find('i')
  expect(element['class']).to match("search-item-icon --#{string}")
end
