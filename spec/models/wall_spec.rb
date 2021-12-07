require 'rails_helper'

RSpec.describe Wall, type: :model do
  let(:point1) { create :point, x: 0 }
  let(:point2) { create :point, x: 0.5 }
  let(:point3) { create :point, y: 1.0 }
  let(:polyline) { create :polyline, points: [point1, point2, point3] }

  it "has a constructor that can create instances" do
    instance = described_class.new
    expect(instance).to be_an_instance_of(described_class)
  end

  it "creates new walls with an empty polyline" do
    wall = described_class.new
    expect(wall.polyline.points).to eq([])
  end

  context "with valid geojson" do
    let(:wall) { build :wall }

    it "has geometry type LineString" do
      expect(wall.to_geojson[:geometry][:type]).to eq("LineString")
    end

    it "has class wall" do
      expect(wall.to_geojson[:properties][:class]).to eq("wall")
    end
  end

  describe "it should be valid" do

    it "when using the factory" do
      wall = build :wall
      expect(wall).to be_valid
    end

    it "when created" do
      wall = create :wall
      expect(wall).to be_valid
    end

    it "when using the constructor" do
      wall = described_class.new(polyline: polyline)
      expect(wall).to be_valid
    end

    it "unless there is no polyline" do
      wall = build :wall
      wall.polyline = nil
      expect(wall).not_to be_valid
    end
  end
end
