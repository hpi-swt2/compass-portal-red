require 'rails_helper'

RSpec.describe Wall, type: :model do
  let(:point1) { create :point, x: 0 }
  let(:point2) { create :point, x: 0.5 }
  let(:point3) { create :point, y: 1.0 }
  let(:points) { [point1, point2, point3] }

  it "has a constructor that can create instances" do
    instance = described_class.new
    expect(instance).to be_an_instance_of(described_class)
  end

  it "creates new walls with an empty list of points" do
    wall = described_class.new
    expect(wall.points).to eq([])
  end

  describe "it should be valid" do
    it "when using the factory" do
      wall = build :wall, points: points
      expect(wall).to be_valid
      expect(wall.points).to eq(points)
    end

    it "when created" do
      wall = create :wall, points: points
      expect(wall).to be_valid
      expect(wall.points).to eq(points)
    end
  end

  describe "db interaction" do
    let(:wall) { create :wall }

    # change the wall and save it to db
    before do
      wall.points = points
      wall.save!
    end

    it "has the wall saved in the db" do
      db_wall = described_class.find(wall.id)
      expect(db_wall).to be_an_instance_of(described_class)
      expect(wall.id).to eq(db_wall.id)
    end

    it "allows adding points to the wall" do
      expect(wall.points.size).to eq(points.size)
    end

    it "keeps an order of added points" do
      expect(wall.points[0].x).to eq(point1.x)
      expect(wall.points[1].x).to eq(point2.x)
    end

    it "allows creating a cycle" do
      # push point 1 again and reload from db, to test if db supports adding a cycle containing the same point twice
      wall.points.push(point1)
      wall.save!
      db_wall = described_class.find(wall.id)

      expect(db_wall.points.size).to eq(points.size + 1)
      expect(db_wall.points[points.size].id).to eq(point1.id)
    end
  end
end
