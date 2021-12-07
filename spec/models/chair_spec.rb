require 'rails_helper'

RSpec.describe Chair, type: :model do
  it "returns not valid because name is empty" do
    chair = described_class.new
    expect(chair).not_to be_valid
  end

  it "returns valid" do
    chair = described_class.new(name: "Test")
    expect(chair).to be_valid
  end

  it "has a person relation" do
    chair = FactoryBot.create :chair
    expect(chair.people.length).to eq(0)
  end

  it "has a room relation" do
    chair = FactoryBot.create :chair
    expect(chair.rooms.length).to eq(0)
  end
end
