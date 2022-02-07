Feature: Search functionality
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
    Then I first see H-E.43 and then Enterprise Platform and Integration Concepts in the list for similar-results

  Scenario: searching a person with status attribute
    Given I am on the search page
    When I enter "Chair Representative"
    And I start the search
    Then I see the search result "Dr. Michael Perscheid"

  Scenario: searching a person lower case
    Given I am on the search page
    When I enter "michael"
    And I start the search
    Then I see the search result "Dr. Michael Perscheid"
  
  Scenario: searching a room lower case
    Given I am on the search page
    When I enter "Printer"
    And I start the search
    Then I see the search result "H-E.42"
    
  Scenario: searching a chair lower case
    Given I am on the search page
    When I enter "enterprise"
    And I start the search
    Then I see the search result "Enterprise Platform and Integration Concepts"

  Scenario: searching a person lower case with additional words 
    Given I am on the search page
    When I enter "prof. dr."
    And I start the search
    Then I see the search result "Prof. Dr. Hasso Plattner"