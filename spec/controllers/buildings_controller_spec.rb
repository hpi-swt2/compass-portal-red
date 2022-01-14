require 'rails_helper'

RSpec.describe BuildingsController, type: :controller do 
  before(:all) do
    @name = "Example Building"
    @building = Building.create(name: @name)
  end

  it 'can create a building' do
    expect(@building).to be_valid
  end

  it 'can find a building'do
    res = Building.find(@building.id)
    expect(res).to eq(@building)
    expect(res.name).to eq(@name)
  end

  it 'can update a building' do
    @building.update(name: "Another name")
    res = Building.find(@building.id)
    expect(res).to eq(@building)
    expect(res.name).to eq("Another name")
  end

  # clean up db after tests
  after(:all) do
    Building.destroy_all
  end
end
