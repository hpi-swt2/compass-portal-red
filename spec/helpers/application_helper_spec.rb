require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it "returns false given a date long ago" do
    datetime = DateTime.new(2021, 2, 3, 4, 5, 6)
    expect(helper.check_human_verification(datetime)).to eq(false)
  end

  it "returns true given today's date" do
    datetime = DateTime.now
    expect(helper.check_human_verification(datetime)).to eq(true)
  end

  it "returns false given no input" do
    datetime = nil
    expect(helper.check_human_verification(datetime)).to eq(false)
  end
end
