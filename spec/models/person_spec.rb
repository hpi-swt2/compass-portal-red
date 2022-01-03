require 'rails_helper'

RSpec.describe Person, type: :model do
  let(:person) { FactoryBot.create :person }

  it "returns not valid because of empty fields" do
    person = described_class.new(last_name: "Perscheid")
    expect(person).not_to be_valid
    person = described_class.new(first_name: "Michael")
    expect(person).not_to be_valid
  end

  it "returns valid" do
    person = described_class.new(last_name: "Perscheid", first_name: "Michael")
    expect(person).to be_valid
  end

  it "has a information relation" do
    expect(person.informations.length).to eq(0)
  end

  it "has a room relation" do
    person.create_room(full_name: "HS1")
    expect(person.room.full_name).to eq("HS1")
  end

  it "has a chair relation" do
    expect(person.chairs.length).to eq(0)
  end

  it "has a user relation" do
    user = FactoryBot.create :user
    person.user = user
    expect(person.user.id).to eq(user.id)
  end

  it "calculates its name correctly" do
    expect(person.name).to eq("#{person.first_name} #{person.last_name}")
  end

  it "calculates its full name correctly" do
    expect(person.full_name).to eq("#{person.title} #{person.first_name} #{person.last_name}")
  end

  it "converts a verification attribute to a column name" do
    expect(person.verified_attribute_to_field(:human_verified_first_name)).to eq(:first_name)
  end
end
