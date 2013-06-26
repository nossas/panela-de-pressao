Feature: edit an update of a campaign
  In order to correct some mistake
  As an admin
  I want to edit an update of a campaign

  @omniauth_test @koala @javascript
  Scenario: when I am an admin and I fill the form right
    Given there is an update for a campaign
    And I'm logged in as admin
    When I'm in the updates page of the campaign
    Then I should see the edit button of the update
    Given I click in the edit button of the update
    And I change the update title to "My update"
    When I submit the edit update form
    Then I should be in the updates page of the campaign
    And I should see the update popup
    And the update title should be "My update"

  @omniauth_test @koala @javascript
  Scenario: when I am an admin and I fill the form wrong
    Given there is an update for a campaign
    And I'm logged in as admin
    And I'm in the updates page of the campaign
    And I click in the edit button of the update
    And I change the update title to ""
    When I submit the edit update form
    Then I should see an error in the title field in the edit update form

  @koala @omniauth_test
  Scenario: when I am not an admin
    Given there is an update for a campaign
    And I'm logged in
    When I'm in the updates page of the campaign
    Then I should not see the edit button of the update
