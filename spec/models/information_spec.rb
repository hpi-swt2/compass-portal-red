require 'rails_helper'

RSpec.describe Information, type: :model do
  it "returns not valid because of empty value" do
    information = described_class.new(key: "Telegram")
    information.create_person(last_name: "Mustermann", first_name: "Max")
    expect(information).not_to be_valid
  end

  it "returns not valid because of empty key" do
    information = described_class.new(value: "@handle")
    information.create_person(last_name: "Mustermann", first_name: "Max")
    expect(information).not_to be_valid
  end

  it "returns not valid because of empty person-relation" do
    information = described_class.new(key: "Telegram", value: "@handle")
    expect(information).not_to be_valid
  end

  it "returns valid" do
    information = described_class.new(key: "Telegram", value: "@handle")
    information.create_person(last_name: "Mustermann", first_name: "Max")
    expect(information).to be_valid
  end

  it "has a person relation" do
    information = FactoryBot.create :information
    expect(information.person.first_name).to eq("Michael")
  end
end
