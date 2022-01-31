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
    expect(person).to respond_to(:informations)
  end

  it "has a room relation" do
    expect(person).to respond_to(:room)
  end

  it "has a chair relation" do
    expect(person).to respond_to(:chairs)
  end

  it "has a course relation" do
    expect(person).to respond_to(:courses)
  end

  it "has a user relation" do
    expect(person).to respond_to(:user)
  end

  it "contains an imagelink to the placeholder if no link was given" do
    person = described_class.new
    expect(person.image_or_placeholder).to match("placeholder_person.png")
  end

  it "calculates its name correctly" do
    expect(person.name).to eq("#{person.first_name} #{person.last_name}")
  end

  it "calculates its full name correctly" do
    expect(person.full_name).to eq("#{person.title} #{person.first_name} #{person.last_name}")
  end

  it "converts a verification attribute to a column name" do
    expect(Person.verified_attribute_to_field(:human_verified_first_name)).to eq(:first_name)
  end
end
