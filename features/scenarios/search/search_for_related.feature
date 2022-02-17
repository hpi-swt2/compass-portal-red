Feature: Searching Related Matches
  In order to get more helpful results when searching
  As a user
  I want to see additional results that are related to my query.

  Background:
    Given a chair and a related person were created
    And an other chair was created

  Scenario: Search for Health & Machine and find Lippert
    Given I am on the search page
    When I enter "Health & Machine"
    And I start the search
    And I see Digital Health & Machine Learning in the list for exact-results
    Then I see Digital Health & Personalized Medicine in the list for similar-results
    And I see Prof. Dr. Christoph Lippert in the list for similar-results
    
  Scenario: Search for Health & Machine and find the chair Digital Health & Machine Learning first
    Given I am on the search page
    When I enter "Health & Machine"
    And I start the search
    Then I first see Digital Health & Personalized Medicine and then Prof. Dr. Christoph Lippert in the list for similar-results

  Scenario: Search for Lippert
    Given I am on the search page
    When I enter "Lippert"
    And I start the search
    Then I see Digital Health & Machine Learning in the list for similar-results