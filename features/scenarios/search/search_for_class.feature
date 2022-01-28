Feature: Searching classes
  In order to find persons, locations and chairs
  As a user
  I want to search them by their class

  Background:
    Given a person was created
    Given a second person was created
    Given a room was created
    Given a chair was created

  Scenario: searching all chairs
    Given I am on the search page
    When I enter "chair"
    And I start the search
    Then I see Enterprise Platform and Integration Concepts in the list for exact-results

  Scenario: searching all persons
    Given I am on the search page
    When I enter "person"
    And I start the search
    Then I see Dr. Michael Perscheid in the list for exact-results
    And I see Prof. Dr. Hasso Plattner in the list for exact-results

  Scenario: searching all rooms
    Given I am on the search page
    When I enter "room"
    And I start the search
    Then I see the search result "H-E.42"
  