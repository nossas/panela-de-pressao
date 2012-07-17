Feature: view my campaigns
  In order to save time looking for my own campaigns
  As a campaigner
  I want to view my campaigns

  @omniauth_test
  Scenario: when I have a campaign
    Given I'm logged in
    And I own a campaign called "Salve a praça Nossa Senhora da Paz" awaiting moderation
    When I click "Minhas campanhas"
    Then I should see "Minhas campanhas"
    And I should see "Salve a praça Nossa Senhora da Paz"
