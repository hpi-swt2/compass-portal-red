require 'rails_helper'

RSpec.describe Chair, type: :model do

  let(:chair) { create :chair }

  it "returns not valid because name is empty" do
    chair = described_class.new
    expect(chair).not_to be_valid
  end

  it "returns valid" do
    expect(chair).to be_valid
  end

  it "has a person relation" do
    expect(chair).to respond_to(:people)
  end

  it "has a room relation" do
    expect(chair).to respond_to(:rooms)
  end

  it "has a string representation" do
    expect(chair.to_string.blank?).to eq(false)
  end
end
