Feature: Search functionality
  In order to find persons, locations and chairs
  As a user
  I want to search them

  Background:
    Given a person was created
    And a second person was created

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

# TODO: test when no additional search results (based on word level search) exist then there is no more-results list and no 'More Results' title