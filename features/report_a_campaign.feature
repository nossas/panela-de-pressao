Feature: report a campaign

  @ssi
  Scenario: when I'm logged in
    Given I'm logged in
    And there is an accepted campaign
    When I go to "this campaign page"
    Then I should see "the warn of campaign without moderator"
    When I click "the report campaign button"
    Then I should be in "this campaign page"
    And the campaign should have now 1 report
    And the "report campaign" email should be sent

  Scenario: when I'm not logged in
    Given there is an accepted campaign
    When I go to "this campaign page"
    Then I should not see "the report campaign button"

  @ssi
  Scenario: when I already reported a campaign
    Given I'm logged in
    And there is an accepted campaign
    And I already reported this campaign
    When I go to "this campaign page"
    Then I should not see "the report campaign button"

  @ssi
  Scenario: when the campaign have a moderator
    Given I'm logged in
    And there is an accepted campaign
    And this campaign have a moderator
    When I go to "this campaign page"
    Then I should not see "the report campaign button"
