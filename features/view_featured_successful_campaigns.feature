Feature: view featured successful campaigns

  Scenario: when there is at least one successful campaign
    Given there is a successful campaign
    When I go to "the homepage"
    Then I should see "this successful campaign"
