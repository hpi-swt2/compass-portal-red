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

  it "value can be retrieved by method" do
    information = FactoryBot.create :information
    expect(information.person.informations.get_value("Telegram")).to eq("@hpi")
  end

  it "human verified is nil by default" do
    information = FactoryBot.create :information
    expect(information.person.informations.get_human_verified("Telegram")).to eq(nil)
  end

  it "human verified can be retrieved by method" do
    information = FactoryBot.create :information, human_verified: Time.zone.local(2002, 10, 31)
    expect(information.person.informations.get_human_verified("Telegram")).to eq(Time.zone.local(2002, 10, 31))
  end
end
