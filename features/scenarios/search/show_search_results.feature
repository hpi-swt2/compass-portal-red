Feature: Search functionality
  In order to find persons, locations and chairs
  As a user
  I want to search them

  Background:
    Given a person was created
    Given a room was created

  Scenario: searching a chair, a room and a person
    Given I am on the search page
    When I enter "Michael"
    And I start the search
    Then I see the search result "Dr Michael Perscheid"

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