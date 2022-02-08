
Feature: Case insensitive search
  In order to find persons, locations and chairs
  As a user
  I want to search them with lower and upper case

  Background:
    Given a person was created
    And a chair was created
    And a room was created
    And a second person was created

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
    