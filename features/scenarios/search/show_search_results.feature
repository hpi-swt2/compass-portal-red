Feature: Basic search functionality
  In order to find persons, locations and chairs
  As a user
  I want to search them

  Background:
    Given a person was created
    And a second person was created
    And a room was created
    And a room without a room type was created
    And a chair was created

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

  Scenario: searching a person with ordered additional results
    Given I am on the search page
    When I enter "Prof. Dr. Meinel"
    And I start the search
    Then I do not see Prof. Dr. Hasso Plattner in the list for exact-results
    And I do not see Dr. Michael Perscheid in the list for exact-results
    And I first see Prof. Dr. Hasso Plattner and then Dr. Michael Perscheid in the list for similar-results
    
  Scenario: searching a room tag
    Given I am on the search page
    When I enter "printer"
    And I start the search
    Then I see the search result "H-E.42"

  Scenario: searching a room_type
    Given I am on the search page
    When I enter "lecture hall"
    And I start the search
    Then I see the search result "H-E.42"

  Scenario: searching a room without a room type
    Given I am on the search page
    When I enter "quiet"
    And I start the search
    Then I see the search result "H-E.43"

  Scenario: searching all rooms
    Given I am on the search page
    When I enter "room"
    And I start the search
    Then I see the search result "H-E.42"
  
  Scenario: searching a person with status attribute
    Given I am on the search page
    When I enter "Chair Representative"
    And I start the search
    Then I see the search result "Dr. Michael Perscheid"