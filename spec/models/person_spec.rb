require 'rails_helper'

RSpec.describe Person, type: :model do
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
    person = FactoryBot.create :person
    expect(person.informations.length).to eq(0)
  end

  it "has a room relation" do
    person = FactoryBot.create :person
    person.create_room(full_name: "HS1")
    expect(person.room.full_name).to eq("HS1")
  end

  it "has a chair relation" do
    person = FactoryBot.create :person
    expect(person.chairs.length).to eq(0)
  end

  it "has a user relation" do
    person = FactoryBot.create :person
    user = FactoryBot.create :user
    person.user = user
    expect(person.user.id).to eq(user.id)
  end
end
