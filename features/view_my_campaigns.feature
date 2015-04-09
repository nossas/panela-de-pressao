Feature: view my campaigns
  In order to save time looking for my own campaigns
  As a campaigner
  I want to view my campaigns

  @omniauth_test @koala @javascript
  Scenario: when I have a campaign
    Given I'm logged in
    And I own an unmoderated campaign called "Salve a praça Nossa Senhora da Paz"
    And I open my profile options
    When I click "the my campaigns button"
    Then I should see "Mobilizações criadas por Nícolas Iensen"
    And I should see "Salve a praça Nossa Senhora da Paz"
