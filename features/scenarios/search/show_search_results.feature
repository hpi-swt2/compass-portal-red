Feature: Search functionality
  In order to find persons, locations and chairs
  As a user
  I want to search them

  Background:
    Given a person was created
    And a second person was created
    Given a room was created
    Given a chair was created

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
    And I see the title for more results
    And I see Dr. Michael Perscheid in the list for more-results

  Scenario: searching a person with no additional results
    Given I am on the search page
    When I enter "Dr."
    And I start the search
    Then I see Prof. Dr. Hasso Plattner in the list for exact-results
    And I see Dr. Michael Perscheid in the list for exact-results
    And I do not see the title for more results
    And I do not see Prof. Dr. Hasso Plattner in the list for more-results
    And I do not see Dr. Michael Perscheid in the list for more-results

  Scenario: searching a person with ordered additional results
    Given I am on the search page
    When I enter "Prof. Dr. Meinel"
    And I start the search
    Then I do not see Prof. Dr. Hasso Plattner in the list for exact-results
    And I do not see Dr. Michael Perscheid in the list for exact-results
    And I first see Prof. Dr. Hasso Plattner and then Dr. Michael Perscheid in the list for more-results
    
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

  Scenario: searching all rooms
    Given I am on the search page
    When I enter "room"
    And I start the search
    Then I see the search result "H-E.42"
  
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
  
  Scenario: prioritized searching with tags
    Given I am on the search page
    When I enter "Room for quiet learning"
    And I start the search
    Then I first see H-E.42 and then Enterprise Platform and Integration Concepts in the list for more-results


