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

  it "saves a 'outdated' problem for every outdated entry of a model" do
    person.update updated_at: DateTime.now.days_ago(184)

    problem_checker.check_for_outdated(Person)

    data_problems = DataProblem.where(["description = 'outdated'"])
    expect(data_problems).not_to be_empty
  end

  context "when checking for conflicts" do
    it "checks if new gathered personal data is in conflict to the actual content of this persons entry" do
      check = problem_checker.check_for_conflict(person, 'first_name')
      expect(check).to be true

      person.update first_name: nil
      check_new = problem_checker.check_for_conflict(person, 'first_name')
      expect(check_new).to be false

      person.update first_name: "Micheal"
      person.update updated_at: DateTime.now.days_ago(2)
      check_old = problem_checker.check_for_conflict(person, 'first_name')
      expect(check_old).to be false
    end

    it "checks if new gathered information about a person is in conflict to already existing information" do
      check_nil = problem_checker.check_for_information_conflict(person, 'Telegram')
      expect(check_nil).to be false

      info = person.informations.create(key: 'Telegram', value: '@hpi')
      check = problem_checker.check_for_information_conflict(person, 'Telegram')
      expect(check).to be true

      info.update updated_at: DateTime.now.days_ago(2)
      check_old = problem_checker.check_for_information_conflict(person, 'Telegram')
      expect(check_old).to be false
    end
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
