When 'a person was created' do
  FactoryBot.create :person, first_name: 'Michael', last_name: 'Perscheid', title: 'Dr.'
end

When 'a second person was created' do
  FactoryBot.create :person, first_name: 'Hasso', last_name: 'Plattner', title: 'Prof. Dr.'
end