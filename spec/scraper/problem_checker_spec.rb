require 'rails_helper'
require "./lib/scraping/problem_checker"

RSpec.describe "ProblemChecker", type: :feature do
  let(:problem_checker) { ProblemChecker.new }
  let(:person) { FactoryBot.create :person }

  # Unit tests

  # it "saves a given problem in the 'data_problems' model" do
  # end

  # it "checks if information for a models entry is in conflict to the entries actual content" do
  # end

  # it "saves a 'outdated' problem for every outdated entry of a model" do
  # end

  it "saves a 'missing' problem for every empty field of a model without 'human_verified'" do
    Person.new(last_name: "Perscheid", first_name: "Michael")
    Person.new(last_name: "Micheal", first_name: "Perscheid")
    Person.verification_attributes.each do |verification_attr|
      Person.where(["last_name = Micheal and first_name = Perscheid"])[verification_attr] = DateTime.now
    end

    problem_checker.check_empty_fields(Person)

    person_id = Person.where(["last_name = Perscheid and first_name = Michael"])[person_id]
    data_problems = data_problems.where(["description = 'missing' and person_id = ?", person_id])
    expect(data_problems).not_to be_empty

    person_id = Person.where(["last_name = Micheal and first_name = Perscheid"])[person_id]
    data_problems = data_problems.where(["description = 'missing' and person_id = ?", person_id])
    expect(data_problems).not_to be_empty
  end
end
