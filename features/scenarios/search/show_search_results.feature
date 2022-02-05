Feature: Basic search functionality
  In order to find persons, locations and chairs
  As a user
  I want to search them

  Background:
    Given a person was created
    And a second person was created

  Scenario: searching a person
    Given I am on the search page
    When I enter "Michael"
    And I start the search
    Then I see Dr. Michael Perscheid in the list for exact-results

  Scenario: searching a person with additional words
    Given I am on the search page
    When I enter "Prof. Dr."
    And I start the search
    Then I see Prof. Dr. Hasso Plattner in the list for exact-results
    And I see the title for similar results
    And I see Dr. Michael Perscheid in the list for similar-results

  Scenario: searching a person with no additional results
    Given I am on the search page
    When I enter "Dr."
    And I start the search
    Then I see Prof. Dr. Hasso Plattner in the list for exact-results
    And I see Dr. Michael Perscheid in the list for exact-results
    And I do not see the title for similar results
    And I do not see Prof. Dr. Hasso Plattner in the list for similar-results
    And I do not see Dr. Michael Perscheid in the list for similar-results

  Scenario: searching a person with ordered additional results
    Given I am on the search page
    When I enter "Prof. Dr. Meinel"
    And I start the search
    Then I do not see Prof. Dr. Hasso Plattner in the list for exact-results
    And I do not see Dr. Michael Perscheid in the list for exact-results
    And I first see Prof. Dr. Hasso Plattner and then Dr. Michael Perscheid in the list for similar-results
  
  Scenario: searching a person with status attribute
    Given I am on the search page
    When I enter "Chair Representative"
    And I start the search
    Then I see the search result "Dr. Michael Perscheid"