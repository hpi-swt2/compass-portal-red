require 'rails_helper'

RSpec.describe FloorsController, type: :controller do
  before(:all) do
    @building = Building.create(name: "x")
    @name = "Example Floor"
    @floor = Floor.create(name: @name, building_id: @building.id)
  end

  it 'can create a floor' do
    expect(@floor).to be_valid
  end

  it 'can find a floor'do
    res = Floor.find(@floor.id)
    expect(res).to eq(@floor)
    expect(res.name).to eq(@name)
  end

  it 'can update a floor' do
    @floor.update(name: "Another name")
    res = Floor.find(@floor.id)
    expect(res).to eq(@floor)
    expect(res.name).to eq("Another name")
  end

  # clean up db after tests
  after(:all) do
    Floor.destroy_all
    Building.destroy_all
  end
end
