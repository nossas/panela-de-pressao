Feature: View all campaigns awaiting moderation
  In order to accept new campaigns
  As an admin
  I want to view all campaigns awaiting moderation

  @omniauth_test
  Scenario: when there is some campaigns awaiting moderation
    Given I'm logged in as admin
    And there is a campaign called "Salve a praça Nossa Senhora da Paz" awaiting moderation
    When I go to the campaigns page
    Then I should see "Salve a praça Nossa Senhora da Paz"

  @omniauth_test
  Scenario: when there is no campaign awaiting moderation
    Given I'm logged in as admin
    When I go to the campaigns page
    Then I should not see "Campanhas aguardando moderação"

  @omniauth_test
  Scenario: when I'm not an admin
    Given I'm logged in
    And there is a campaign called "Salve a praça Nossa Senhora da Paz" awaiting moderation
    When I go to the campaigns page
    Then I should not see "Campanhas aguardando moderação"
    And I should not see "Salve a praça Nossa Senhora da Paz"

  Scenario: when I'm not logged in
    Given there is a campaign called "Salve a praça Nossa Senhora da Paz" awaiting moderation
    When I go to the campaigns page
    Then I should not see "Campanhas aguardando moderação"
    And I should not see "Salve a praça Nossa Senhora da Paz"
