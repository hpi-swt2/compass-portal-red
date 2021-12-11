Feature: Search functionality
  In order to find persons, locations and chairs
  As a user
  I want to search them

  Background:
    Given a person was created

  Scenario: searching on a chair, a room and a person on home page
    Given I am on the home page
    When I enter "Michael"
    And I start the search
    Then I see the search result "Dr Michael Perscheid"
    And I see next to the search result an icon for a "person"