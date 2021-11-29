require 'rails_helper'

# TODO: add some demo outerShape-points, walls and points of interests to the factory
# TODO: test that newly created rooms are valid and that factory-created rooms are valid
RSpec.describe Room, type: :model do
  let(:point1) { create :point }
  let(:point2) { create :point, x: -1.5 }

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

  describe "it should be valid" do
    let(:point_of_interest) { create :point_of_interest, point: point1 }
    let(:outer_shape) { [point1, (create :point, y: -1.5), (create :point, x: -1.5, y: -1.5), point2] }
    let(:room) do
      create :room,
             outerShape: outer_shape,
             point_of_interests: [point_of_interest],
             walls: [ (build :wall) ]
    end

    it "when using the factory" do
      room = build :room, outerShape: outer_shape, point_of_interests: [point_of_interest], walls: []
      expect(room).to be_valid
      expect(room.outerShape).to eq(outer_shape)
      expect(room.walls).to eq([])
      expect(room.point_of_interests).to eq([point_of_interest])
    end

    it "when created" do
      expect(room).to be_valid
    end

    it "with walls, outer shape, point of interests" do
      expect(room.outerShape).to eq(outer_shape)
      expect(room.point_of_interests).to eq([point_of_interest])
    end
  end

  describe "db interaction" do
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
