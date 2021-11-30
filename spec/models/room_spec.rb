require 'rails_helper'

RSpec.describe Room, type: :model do
  it "creates a room" do
    room = described_class.new(house: "H", number: "42", floor: "E", full_name: "H-E.42")
    expect(room.house).to eq("H")
    expect(room.number).to eq("42")
    expect(room.floor).to eq("E")
    expect(room.full_name).to eq("H-E.42")
  end

  it "returns not valid because full_name is empty" do
    room = described_class.new(house: "H", number: "42", floor: "E")
    expect(room).not_to be_valid
  end

  it "returns valid" do
    room = described_class.new(full_name: "H-E.42")
    expect(room).to be_valid
  end

  it "has a chair relation" do
    room = FactoryBot.create :room
    expect(room.chairs.length).to eq(0)
  end

  it "has a person relation" do
    room = FactoryBot.create :room
    expect(room.people.length).to eq(0)
  end

  it "has a tag relation" do
    room = FactoryBot.create :room
    expect(room.tags.length).to eq(0)
  end

  it "has a room type relation" do
    room = FactoryBot.create :room
    expect(room.room_types.length).to eq(0)
  end
end
