Feature: finish a campaign
  In order to stop pokes
  As an admin
  I want to finish a campaign

  @omniauth_test
  Scenario: I'm logged in as admin and the campaign is succeed
    Given I'm logged in as admin
    And there is a campaign called "Save the Whales!"
    And I'm in this campaign page
    When I click "the victory campaign button"
    Then I should be in this campaign page
    And I should see "Vitória!"
    And I should not see "the pokes buttons" in "the right sidebar"

  @omniauth_test
  Scenario: I'm logged in as admin and the campaign is not succeed
    Given I'm logged in as admin
    And there is a campaign called "Save the Whales!"
    And I'm in this campaign page
    When I click "the lose campaign button"
    Then I should be in this campaign page
    And I should see "Não foi dessa vez..."
    And I should not see "the pokes buttons" in "the right sidebar"

  Scenario: I'm not logged in
    Given there is a campaign called "Save the Whales!"
    When I go to "this campaign page"
    Then I should not see "Encerrar campanha"

  @omniauth_test
  Scenario: I'm the campaigns owner
    Given I'm logged in
    And I own a campaign called "Save the Whales!"
    When I go to "this campaign page"
    Then I should not see "Encerrar campanha"
