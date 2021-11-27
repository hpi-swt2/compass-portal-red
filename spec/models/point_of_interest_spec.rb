require 'rails_helper'

RSpec.describe PointOfInterest, type: :model do
  it "has a constructor that can create instances" do
    instance = described_class.new
    expect(instance).to be_an_instance_of(described_class)
  end

  describe "it should be valid" do
    it "with a point" do
      point = build :point
      point_of_interest = described_class.new(point: point)
      expect(point_of_interest).to be_valid
    end

    it "when using the factory" do
      point_of_interest = build :point_of_interest
      expect(point_of_interest).to be_valid
    end
  end

  describe "it should not be valid" do
    it "without a point" do
      point_of_interest = build :point_of_interest
      point_of_interest.point = nil
      expect(point_of_interest).not_to be_valid
    end
  end
end
