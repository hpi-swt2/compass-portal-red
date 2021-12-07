require 'rails_helper'

RSpec.describe Polyline, type: :model do
  let(:point1) { create :point, x: 0 }
  let(:point2) { create :point, x: 0.5 }
  let(:point3) { create :point, y: 1.0 }
  let(:points) { [point1, point2, point3] }

  it "has a constructor that can create instances" do
    instance = described_class.new
    expect(instance).to be_an_instance_of(described_class)
  end

  it "creates new polylines with an empty list of points" do
    polyline = described_class.new
    expect(polyline.points).to eq([])
  end

  context "with valid arguments" do
    it "is valid with factory" do
      polyline = build :polyline, points: points
      expect(polyline).to be_valid
      expect(polyline.points).to eq(points)
    end

    it "is valid with persistence" do
      polyline = create :polyline, points: points
      expect(polyline).to be_valid
      expect(polyline.points).to eq(points)
    end

    it "is valid with constructor" do
      polyline = described_class.new(points: points)
      expect(polyline).to be_valid
      expect(polyline.points).to eq(points)
    end
  end

  describe "db interaction" do
    let(:polyline) { create :polyline }

    # change the polyline and save it to db
    before do
      polyline.points = points
      polyline.save!
    end

    it "has the polyline saved in the db" do
      db_polyline = described_class.find(polyline.id)
      expect(db_polyline).to be_an_instance_of(described_class)
      expect(db_polyline.id).to eq(polyline.id)
    end

    it "contains exactly the added points" do
      expect(polyline.points.size).to eq(points.size)
    end

    it "keeps an order of added points" do
      expect(polyline.points[0].x).to eq(point1.x)
      expect(polyline.points[1].x).to eq(point2.x)
    end

    it "allows creating a cycle" do
      # push point 1 again and reload from db, to test if db supports adding a cycle containing the same point twice
      polyline.points.push(point1)
      polyline.save!
      db_polyline = described_class.find(polyline.id)

      expect(db_polyline.points.size).to eq(points.size + 1)
      expect(db_polyline.points[points.size].id).to eq(point1.id)
    end
  end
end
