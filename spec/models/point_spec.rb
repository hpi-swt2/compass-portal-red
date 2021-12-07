require 'rails_helper'

RSpec.describe Point, type: :model do
  it "has a constructor that can create instances" do
    instance = described_class.new
    expect(instance).to be_an_instance_of(described_class)
  end

  it "can be compared to another point with ==" do
    point1 = create :point
    point2 = create :point
    expect(point1 == point2).to be_truthy
  end

  context "with valid arguments" do
    it "is valid with x- and y-value" do
      point = described_class.new(x: 1.0, y: -1.5)
      expect(point).to be_valid
    end

    it "is valid with factory" do
      point = build :point
      expect(point).to be_valid
    end
  end

  context "with invalid arguments" do
    let(:point) { build :point }

    it "is invalid with missing x-value" do
      point.x = nil
      expect(point).not_to be_valid
    end

    it "is invalid with missing y-value" do
      point.y = nil
      expect(point).not_to be_valid
    end
  end
end
