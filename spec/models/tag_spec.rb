require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "returns not valid because name is empty" do
    tag = described_class.new
    expect(tag).not_to be_valid
  end

  it "returns valid" do
    tag = described_class.new(name: "ruhig")
    expect(tag).to be_valid
  end

  it "has a room relation" do
    tag = FactoryBot.create :tag
    expect(tag.rooms.length).to eq(0)
  end
end
