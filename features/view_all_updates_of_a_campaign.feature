Feature: view all updates of a campaign
  In order to keep myself updated to a campaign
  As a visitor
  I want to view all updates of a campaign

  Scenario: when there is no update
    Given there is an accepted campaign
    And I'm in this campaign page
    When I click in the updates button
    Then I should see that there is no update yet

  @koala
  Scenario: when there are some updates
    Given there is an accepted campaign
    And there is an update for this campaign
    And I'm in this campaign page
    When I click in the updates button
    Then I should see the update
