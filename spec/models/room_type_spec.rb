require 'rails_helper'

RSpec.describe RoomType, type: :model do
  it "creates a room type" do
    room_type = described_class.new(name: "Poolraum")
    expect(room_type.name).to eq("Poolraum")
  end

  it "returns not valid because name is empty" do
    room_type = described_class.new()
    expect(room_type).not_to be_valid
  end

  it "returns valid" do
    room_type = described_class.new(name: "Poolraum")
    expect(room_type).to be_valid
  end

  it "has a room relation" do
    room_type = FactoryBot.create :room_type
    expect(room_type.rooms.length).to eq(0)
  end
end
