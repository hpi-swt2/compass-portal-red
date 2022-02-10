Feature: Persist search query
  Background:
    Given a chair was created

  Scenario: persist search query when navigating from search to map page
    Given I am on the search page
    When I enter "Chair"
    And I navigate to the "Map" page
    Then I can still see the search query "Chair" in the search bar

  Scenario: show search results when navigating from map to search page
    Given I am on the map page
    When I enter "Chair"
    And I navigate to the "Search" page
    Then I can still see the search query "Chair" in the search bar
    Then I see Enterprise Platform and Integration Concepts in the list for exact-results
