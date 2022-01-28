When('I start the search') do
  find_by_id('search').native.send_keys(:return)
end

When('I enter {string}') do |string|
  fill_in 'query', with: string
end

Then('I see the search result {string}') do |string|
  expect(page).to have_content(string)
end

Then(/^I see (.*) in the list for (.*)$/) do |name, result_type|
  expect(page).to have_content(name)
  expect(page.find('div', class: 'list-group', text: name)[:id]).to eq result_type
end

Then('I see the title for similar results') do
  expect(page).to have_text('Similar Results')
end

Then('I do not see the title for similar results') do
  expect(page).not_to have_text('Similar Results')
end

Then(/^I do not see (.*) in the list for (.*)$/) do |name, result_type|
  element = page.find('div', class: 'list-group', id: result_type)
  expect(element).not_to have_content(name)
end

Then('I see next to the search result an icon for a {string}') do |string|
  element = page.find('i')
  expect(element['class']).to match("search-item-icon --#{string}")
end

Then(/^I first see (.*) and then (.*) in the list for (.*)$/) do |name_first, name_second, result_type|
  element = page.find('div', class: 'list-group', id: result_type)
  first = element.all('a').first
  second = element.all('a')[1]
  expect(first).to have_text(name_first)
  expect(second).to have_text(name_second)
end
