Feature: Persist search query
  Scenario: persist search query when navigating between pages
    Given I am on the search page
    When I enter "Chair"
    And I navigate to the map page
    Then I can still see the search query "Chair" in the search bar
