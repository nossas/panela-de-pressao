Feature: create an update for a campaign
  In order to keep people up to date with the campaign
  As a campaign's owner
  I want to create an update for my campaign

  @omniauth_test @javascript @koala
  Scenario: when I'm the campaign's owner and submit the form right
    Given I'm logged in
    And I own a campaign
    And I'm in this campaign page
    When I click in the updates button
    Then I should see the new update button
    Given I click in the new update button
    And I fill the new update form right
    When I submit the new update form
    Then I should be in "the updates page of the campaign"
    And I should see the new update in a facebox

  @omniauth_test @javascript @koala
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

  @omniauth_test @javascript
  Scenario: when I'm an admin user and submit the form wrong
    Given I'm logged in as admin
    And there is a campaign
    And I'm in this campaign page
    And I click in the updates button
    And I click in the new update button
    When I submit the new update form
    Then I should be in "the updates page of the campaign"
    And I should see the update form errors

  @omniauth_test
  Scenario: when I'm not an admin user nor the campaign's author
    Given I'm logged in
    And there is a campaign
    And I'm in this campaign page
    When I click in the updates button
    Then I should not see the new update button
