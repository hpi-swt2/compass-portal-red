require 'rails_helper'

RSpec.describe PointOfInterest, type: :model do
  it "has a constructor that can create instances" do
    instance = described_class.new
    expect(instance).to be_an_instance_of(described_class)
  end

  context "with valid arguments" do
    it "is valid with a point and type" do
      point = build :point
      room = build :room
      point_of_interest = described_class.new(point: point, room: room, point_type: "entrance")
      expect(point_of_interest).to be_valid
    end

    it "is valid when using the factory" do
      point_of_interest = build :point_of_interest
      expect(point_of_interest).to be_valid
    end
  end

  context "with invalid arguments" do
    it "is invalid without a point" do
      point_of_interest = build :point_of_interest
      point_of_interest.point = nil
      expect(point_of_interest).not_to be_valid
    end

    it "is invalid without a type" do
      point = build :point
      point_of_interest = described_class.new(point: point)
      expect(point_of_interest).not_to be_valid
    end
  end
end
