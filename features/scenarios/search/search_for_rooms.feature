Feature: Searching for Rooms
    In order to find rooms
    As a user
    I want to search them by tag and type

  Background:
    Given a room was created
    Given a chair was created

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
 
  Scenario: prioritized searching with tags
    Given I am on the search page
    When I enter "Room for quiet learning"
    And I start the search
    Then I first see H-E.42 and then Enterprise Platform and Integration Concepts in the list for more-results