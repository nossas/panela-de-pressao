Feature: remove an update of a campaign
  In order to clean up the campaign's updates
  As an admin
  I want to remove an update of a campaign

  @koala @omniauth_test @ssi
  Scenario: when I am an admin
    Given there is an update for a campaign
    And I'm logged in as admin
    When I'm in the updates page of the campaign
    Then I should see the remove update button
    When I click on the remove update button
    Then I should be in "the updates page of the campaign"
    And I should not see the update in the list of updates
    And I should see a successful message

  @koala
  Scenario: when I am not an admin
    Given there is an update for a campaign
    When I'm in the updates page of the campaign
    Then I should not see the remove update button
