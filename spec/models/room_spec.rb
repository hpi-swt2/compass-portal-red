require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:point1) { create :point }
  let(:point2) { create :point, x: -1.5 }

  context "when creating the room" do
    let(:room) { FactoryBot.create :room }

    it "has a chair relation" do
      expect(room).to respond_to(:chairs)
    end

    it "has a person relation" do
      expect(room).to respond_to(:people)
    end

    it "has a tag relation" do
      expect(room).to respond_to(:tags)
    end

    it "has a room type relation" do
      expect(room).to respond_to(:room_types)
    end
  end

  it "has a constructor that can create instances" do
    instance = described_class.new
    expect(instance).to be_an_instance_of(described_class)
  end

  context "when creating new rooms" do
    let(:room) { described_class.new }

    it "contains an empty list of points in the outer shape" do
      expect(room.outer_shape.points).to eq([])
    end

    it "contains an empty list of walls" do
      expect(room.walls).to eq([])
    end

    it "contains an empty list of points of interests" do
      expect(room.point_of_interests).to eq([])
    end

    it "contains an imagelink to the placeholder" do
      expect(room.image).to match("placeholder_room.png")
    end
  end

  context "with valid geojson" do
    let(:room) { build :room }

    it "has geometry type Polygon" do
      expect(room.to_geojson[1][:geometry][:type]).to eq("Polygon")
    end

    it "has class outer-shape" do
      expect(room.to_geojson[1][:properties][:class]).to eq("outer-shape")
    end
  end

  describe "validation" do
    let(:point_of_interest) { create :point_of_interest, point: point1 }
    let(:outer_shape) do
      create :polyline,
             points: [point1, (create :point, y: -1.5), (create :point, x: -1.5, y: -1.5), point2]
    end

    shared_examples "room with corresponding argument" do
      it "wall" do
        expect(room.walls).to eq([])
      end

      it "points of interest" do
        expect(room.point_of_interests).to eq([point_of_interest])
      end

      it "outer shape" do
        expect(room.outer_shape).to eq(outer_shape)
      end

      it "valid" do
        expect(room).to be_valid
      end

      it "a building" do
        building = create :building
        room.building = building
        room.save!

        db_room = described_class.find(room.id)
        expect(db_room.building).to eq(building)
      end
    end

    context "when using the factory" do
      let(:room) do
        build :room,
              outer_shape: outer_shape,
              point_of_interests: [point_of_interest],
              walls: []
      end

      it_behaves_like "room with corresponding argument"
    end

    context "when persisted" do
      let(:room) do
        create :room,
               outer_shape: outer_shape,
               point_of_interests: [point_of_interest],
               walls: []
      end

      it_behaves_like "room with corresponding argument"

      it "even without a building" do
        room.building = nil
        expect(room).to be_valid
      end

      it "unless there is no outer shape" do
        room.outer_shape = nil
        expect(room).not_to be_valid
      end

      it "restricts to delete outer shape" do
        outer_shape = Polyline.find(room.outer_shape.id)
        expect { outer_shape.delete }.to raise_error(ActiveRecord::InvalidForeignKey)
      end

      it "allows to delete wall" do
        wall = build :wall
        room.walls.push(wall)
        room.save!

        expect { wall.delete }.not_to raise_error
      end
    end
  end

  describe "db interaction" do
    let(:room) { create :room }
    let(:db_room) { described_class.find(room.id) }

    context "when adding points to the shape" do
      before do
        room.outer_shape.points = [point1, point2]
        room.save!
      end

      it "has correct amount of points" do
        expect(db_room.outer_shape.points.size).to eq(2)
      end

      it "keeps point order" do
        expect(db_room.outer_shape.points[0].id).to eq(point1.id)
        expect(db_room.outer_shape.points[1].id).to eq(point2.id)
      end
    end
  end
end
