require 'rails_helper'

RSpec.describe Point, type: :model do
  it "has a constructor that can create point instances" do
    point = described_class.new
    expect(point).to be_an_instance_of(described_class)
  end

  describe "it should be valid" do
    it "with x- and y-value" do
      point = build :point
      expect(point).to be_valid
    end
  end

  describe "it should not be valid" do
    let(:point) { build :point }

    it "without x-value" do
      point.x = nil
      expect(point).not_to be_valid
    end

    it "without y-value" do
      point.y = nil
      expect(point).not_to be_valid
    end
  end
end
