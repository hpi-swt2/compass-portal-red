require 'rails_helper'

RSpec.describe ChairsController, type: :controller do 
  before(:all) do
    @person = Person.create(first_name: "x", last_name: "x")
    @name = "Example Chair"
    @chair = Chair.create(name: @name, person_ids: [ @person.id ])
  end

  it 'can create a chair' do
    expect(@chair).to be_valid
  end

  it 'can find a char'do
    res = Chair.find(@chair.id)
    expect(res).to eq(@chair)
    expect(res.name).to eq(@name)
  end

  it 'can update a char' do
    @chair.update(name: "Another name")
    res = Chair.find(@chair.id)
    expect(res).to eq(@chair)
    expect(res.name).to eq("Another name")
  end

  # clean up db after tests
  after(:all) do
    Chair.destroy_all
    Person.destroy_all
  end
end
