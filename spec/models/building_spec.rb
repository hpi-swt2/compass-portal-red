require 'rails_helper'

RSpec.describe Building, type: :model do
  let(:floor1) { create :floor }
  let(:floor2) { create :floor }
  let(:floors) { [floor1, floor2] }
  let(:name) { "Example building" }

  it "has a constructor that can create instances" do
    instance = described_class.new
    expect(instance).to be_an_instance_of(described_class)
  end

  it "creates new buildings with an empty list of floors" do
    building = described_class.new
    expect(building.floors).to eq([])
  end

  it "can have multiple floors" do
    building = create :building, floors: floors
    expect(building.floors.size).to be > 1
  end

  it "can access the building from the floor" do
    building = create :building, floors: floors
    expect(building.floors).not_to be_empty
    expect(floors[0].building.id).to eq(building.id)
  end

  it "can create a geojson containing the correct number of features" do
    building = create :building
    expect(building.to_geojson.length).to eq(0)
  end

  context "with valid arguments" do
    it "is valid when using the factory" do
      building = build :building
      expect(building).to be_valid
    end

    it "is valid with persistence" do
      building = create :building, floors: floors
      expect(building).to be_valid
      expect(building.floors).to eq(floors)
    end

    it "is valid when using the constructor" do
      building = described_class.new(name: name, floors: floors)
      expect(building).to be_valid
      expect(building.floors).to eq(floors)
    end
  end
end
