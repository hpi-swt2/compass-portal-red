Feature: 
  In order to find information about a chair, room or person on HPI campus
  As a user
  I want to search related information like tags and types (room_types)

  Background:
    Given a room was created

  Scenario: searching a room_type
    Given I am on the search page
    When I enter "printer"
    And I start the search
    Then I see the search result "H-E.42"

  Scenario: searching a room_type
    Given I am on the search page
    When I enter "lecture hall"
    And I start the search
    Then I see the search result "H-E.42"