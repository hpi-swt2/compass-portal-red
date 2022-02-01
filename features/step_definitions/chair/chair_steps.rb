When 'a chair was created' do
  FactoryBot.create :chair
end

When 'a chair and a related person were created' do
  person = Person.create(first_name: 'Christoph', last_name: 'Lippert', title: 'Prof. Dr.')
  Chair.create(name: "Digital Health & Machine Learning", people: [person])
end

When 'an other chair was created' do
  Chair.create(name: "Digital Health & Personalized Medicine")
end