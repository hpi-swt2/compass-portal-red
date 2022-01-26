require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:course) { FactoryBot.create :course }
  
  it "returns not valid because name is empty" do
    course = described_class.new
    expect(course).not_to be_valid
  end

  it "returns valid" do
    expect(course).to be_valid
  end

  it "has a person relation" do
    expect(course.people.length).to eq(1)
  end

  it "has a room relation" do
    room = FactoryBot.create :room
    course.room = room
    expect(course.room.id).to eq(room.id)
  end

  it "has a course time relation" do
    expect(course.course_times.length).to eq(1)
  end
end
