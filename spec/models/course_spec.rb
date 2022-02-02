require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:course) { create :course }

  it "returns not valid because name is empty" do
    course = described_class.new
    expect(course).not_to be_valid
  end

  it "returns valid if name not empty" do
    course = described_class.new(name: "Example Course")
    expect(course).to be_valid
  end

  it "has a person relation" do
    expect(course).to respond_to(:people)
  end

  it "has a room relation" do
    expect(course).to respond_to(:room)
  end

  it "has a course time relation" do
    expect(course).to respond_to(:course_times)
  end
end
