Feature: report a campaign

  @ssi
  Scenario: when I'm logged in
    Given I'm logged in
    And there is an accepted campaign
    When I go to this campaign page
    Then I should see "the warn of campaign without moderator"
    When I click "the report campaign button"
    Then I should be in this campaign page
    And the campaign should have now 1 report

  Scenario: when I'm not logged in
  Scenario: when I already reported a campaign
  Scenario: when the campaign have a moderator
