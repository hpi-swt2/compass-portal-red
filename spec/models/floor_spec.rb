require 'rails_helper'

RSpec.describe Floor, type: :model do
  let(:building) { create :building }
  let(:name) { "Example floor" }
  let(:room1) { create :room }
  let(:room2) { create :room }
  let(:rooms) { [room1, room2] }

  it "has a constructor that can create instances" do
    instance = described_class.new
    expect(instance).to be_an_instance_of(described_class)
  end

  it "creates new floors with an empty list of rooms" do
    floor = described_class.new
    expect(floor.rooms).to eq([])
  end

  # TODO
  # it "can create a geojson containing the correct number of features" do
  #   floor = create :floor
  #   expect(floor.to_geojson.length).to eq(0)
  # end

  it "can have multiple rooms" do
    floor = create :floor, rooms: rooms
    expect(floor.rooms.size).to be > 1
  end

  it "can access the floor from the room" do
    floor = create :floor, rooms: rooms
    expect(floor.rooms).not_to be_empty
    expect(rooms[0].floor.id).to eq(floor.id)
  end

  context "with valid arguments" do
    it "is valid when using the factory" do
      floor = build :floor
      expect(floor).to be_valid
    end

    it "is valid with persistence" do
      floor = create :floor, rooms: rooms
      expect(floor).to be_valid
      expect(floor.rooms).to eq(rooms)
    end

    it "is valid when using the constructor" do
      floor = described_class.new(name: name, building: building, rooms: rooms)
      expect(floor).to be_valid
      expect(floor.rooms).to eq(rooms)
    end
  end
end
