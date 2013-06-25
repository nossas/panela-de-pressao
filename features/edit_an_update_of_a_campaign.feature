Feature: edit an update of a campaign
  In order to correct some mistake
  As an admin
  I want to edit an update of a campaign

  @omniauth_test @koala @javascript
  Scenario: when I am an admin and I fill the form right
    Given there is an update for a campaign
    And I'm logged in as admin
    When I'm in the updates page of this campaign
    Then I should see the edit button of the update
    Given I click in the edit button of the update
    And I change the update title to "My update"
    When I submit the edit update form
    Then I should be in the updates page of the campaign
    And I should see the update popup
    And the update title should be "My update"

  Scenario: when I am an admin and I fill the form wrong
  Scenario: when I am not an admin
