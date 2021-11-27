require 'rails_helper'

# TODO: add some demo outerShape-points, walls and points of interests to the factory
# TODO: test that newly created rooms are valid and that factory-created rooms are valid
RSpec.describe Room, type: :model do
  it "has a constructor that can create instances" do
    instance = described_class.new
    expect(instance).to be_an_instance_of(described_class)
  end

  describe "it should create new rooms with an empty list of" do
    it "points in the empty shape" do
      room = described_class.new
      expect(room.outerShape).to eq([])
    end

    it "walls" do
      room = described_class.new
      expect(room.walls).to eq([])
    end

    it "points of interests" do
      room = described_class.new
      expect(room.point_of_interests).to eq([])
    end
  end

  describe "db interaction" do
    let(:point1) { create :point }
    let(:point2) { create :point }
    let(:room) { create :room }

    it "allows adding points to the shape" do
      room.outerShape = [point1, point2]
      room.save!
      db_room = described_class.find(room.id)


      expect(db_room.outerShape.size).to eq(2)
      expect(db_room.outerShape[0].id).to eq(point1.id)
      expect(db_room.outerShape[1].id).to eq(point2.id)
    end
  end
end
