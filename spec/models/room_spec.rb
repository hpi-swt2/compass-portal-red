require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:point1) { create :point }
  let(:point2) { create :point, x: -1.5 }

  it "has a constructor that can create instances" do
    instance = described_class.new
    expect(instance).to be_an_instance_of(described_class)
  end

  describe "it should create new rooms with an empty list of" do
    it "points in the outer shape" do
      room = described_class.new
      expect(room.outer_shape.points).to eq([])
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

  describe "it should be valid" do
    let(:point_of_interest) { create :point_of_interest, point: point1 }
    let(:outer_shape) { create :polyline, points: [point1, (create :point, y: -1.5), (create :point, x: -1.5, y: -1.5), point2] }
    let(:room) do
      create :room,
             outer_shape: outer_shape,
             point_of_interests: [point_of_interest],
             walls: [(build :wall)]
    end

    it "when using the factory" do
      room = build :room, outer_shape: outer_shape, point_of_interests: [point_of_interest], walls: []
      expect(room).to be_valid
      expect(room.outer_shape).to eq(outer_shape)
      expect(room.walls).to eq([])
      expect(room.point_of_interests).to eq([point_of_interest])
    end

    it "when created" do
      expect(room).to be_valid
    end

    it "with walls, outer shape, point of interests" do
      expect(room.outer_shape).to eq(outer_shape)
      expect(room.point_of_interests).to eq([point_of_interest])
    end

    it "unless there is no outer shape" do
      room.outer_shape = nil
      expect(room).not_to be_valid
    end
  end

  describe "db interaction" do
    let(:room) { create :room }

    it "allows adding points to the shape" do
      db_room = described_class.find(room.id)
      room.outer_shape.points = [point1, point2]
      room.save!

      expect(db_room.outer_shape.points.size).to eq(2)
      expect(db_room.outer_shape.points[0].id).to eq(point1.id)
      expect(db_room.outer_shape.points[1].id).to eq(point2.id)
    end
  end
end
