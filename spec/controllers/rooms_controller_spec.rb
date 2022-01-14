require 'rails_helper'

RSpec.describe RoomsController, type: :controller do 
  before(:all) do
    @building = Building.create(name: "x")
    @floor = Floor.create(name: "x", building_id: @building.id)
    @name = "Example Room"
    @room = Room.create(full_name: @name, floor_id: @floor.id)
  end

  it 'can create a room' do
    expect(@room).to be_valid
  end

  it 'can find a room'do
    res = Room.find(@room.id)
    expect(res).to eq(@room)
    expect(res.full_name).to eq(@name)
  end

  it 'can update a room' do
    @room.update(full_name: "Another name")
    res = Room.find(@room.id)
    expect(res).to eq(@room)
    expect(res.full_name).to eq("Another name")
  end

  # clean up db after tests
  after(:all) do
    Room.destroy_all
    Floor.destroy_all
    Building.destroy_all
  end
end
