require 'rails_helper'

RSpec.describe Building, type: :model do
  let(:room1) { create :room }
  let(:room2) { create :room, point_of_interests: [(create :point_of_interest)] }
  let(:rooms) { [room1, room2] }

  it "has a constructor that can create instances" do
    instance = described_class.new
    expect(instance).to be_an_instance_of(described_class)
  end

  it "creates new buildings with an empty list of rooms" do
    building = described_class.new
    expect(building.rooms).to eq([])
  end

  it "can have multiple rooms" do
    building = create :building, rooms: rooms
    expect(building.rooms).not_to eq([])
    expect(rooms[0].building).to eq(building)
    expect(rooms[0].building.id).to eq(building.id)
  end

  describe "it should be valid" do
    it "when using the factory" do
      building = build :building
      expect(building).to be_valid
    end

    it "when created" do
      building = create :building, rooms: rooms
      expect(building).to be_valid
      expect(building.rooms).to eq(rooms)
    end

    it "when created with the constructor" do
      building = described_class.new(rooms: rooms)
      expect(building).to be_valid
      expect(building.rooms).to eq(rooms)
    end
  end
end
