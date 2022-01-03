require 'rails_helper'
require "./lib/scraping/problem_checker"

RSpec.describe "ProblemChecker", type: :feature do
  let(:problem_checker) { ProblemChecker.new }
  let(:person) { create :person }

  # Unit tests

  it "saves a given problem in the 'data_problems' model" do
    problem_checker.save_problem('conflicting', person, "last_name")

    data_problems = DataProblem.where(["description = 'conflicting'"])
    expect(data_problems.length).to eq 1
  end

  it "checks if information for a models entry is in conflict to the entries actual content" do
    check = problem_checker.check_for_conflict(person, 'first_name')
    expect(check).to be true

    person.update first_name: nil
    check = problem_checker.check_for_conflict(person, 'first_name')
    expect(check).to be false
  end

  it "saves a 'outdated' problem for every outdated entry of a model" do
    person.update updated_at: DateTime.now.days_ago(184)

    problem_checker.check_for_outdated(Person)

    data_problems = DataProblem.where(["description = 'outdated'"])
    expect(data_problems).not_to be_empty
  end

  context "when checking for empty fields" do
    it "saves a 'missing' problem for every empty field of a model" do
      person.update first_name: nil

      problem_checker.check_empty_fields(Person)

      data_problems = DataProblem.where(["description = 'missing'"])
      expect(data_problems).not_to be_empty
    end
  end
end
