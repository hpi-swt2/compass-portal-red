Feature: Search functionality
  In order to find persons, locations and chairs
  As a user
  I want to search them

  Background:
    Given a person was created

  Scenario: searching a chair, a room and a person
    Given I am on the search page
    When I enter "Michael"
    And I start the search
    Then I see the search result "Dr Michael Perscheid"
