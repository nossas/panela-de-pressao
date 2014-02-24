Feature: create an update for a campaign
  In order to keep people up to date with the campaign
  As an admin
  I want to create an update for a campaign

  @omniauth_test @javascript @koala @ssi
  Scenario: when I'm an admin user and submit the form right
    Given I'm logged in as admin
    And there is a campaign
    And I'm in this campaign page
    When I click in the updates button
    Then I should see the new update button
    Given I click in the new update button
    And I fill the new update form right
    When I submit the new update form
    Then I should be in "the updates page of the campaign"
    And I should see the new update in a facebox

  @omniauth_test @javascript @ssi
  Scenario: when I'm an admin user and submit the form wrong
    Given I'm logged in as admin
    And there is a campaign
    And I'm in this campaign page
    And I click in the updates button
    And I click in the new update button
    When I submit the new update form
    Then I should be in "the updates page of the campaign"
    And I should see the update form errors

  @omniauth_test @ssi
  Scenario: when I'm not an admin user
    Given I'm logged in
    And there is a campaign
    And I'm in this campaign page
    When I click in the updates button
    Then I should not see the new update button
