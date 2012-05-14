Feature: accept a campaign
  In order to ensure the quality of campaigns
  As an admin
  I want to accept a campaign

  @omniauth_test
  Scenario: when I'm admin
    Given I'm logged in as admin
    And there is a campaign called "Salve a praça Nossa Senhora da Paz" awaiting moderation
    And I'm in the campaigns page
    And I'm in this campaign editing page
    Then I should not see "the create campaign button"
    When I press "Aceitar campanha"
    Then I should be in this campain page
    And I should see "Está valendo, campanha no ar!"
    And this campaign should be accepted

  @omniauth_test
  Scenario: when I own a campaign awaiting moderation
    Given I'm logged in
    And I own a campaign called "Salve a praça Nossa Senhora da Paz" awaiting moderation
    When I go to this campaign editing page
    Then I should not see "the accept campaign button"
