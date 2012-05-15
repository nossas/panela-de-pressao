Feature: view my campaigns
  In order to save time looking for my own campaigns
  As a campaigner
  I want to view my campaigns

  @omniauth_test
  Scenario: when I have a campaign
    Given I'm logged in
    And I own a campaign called "Salve a praça Nossa Senhora da Paz" awaiting moderation
    When I go to the campaigns page
    Then I should see "Minhas campanhas"
    And I should see "Salve a praça Nossa Senhora da Paz"
    
  @omniauth_test
  Scenario: when I don't have any campaign
    Given I'm logged in
    When I go to the campaigns page
    Then I should not see "Minhas campanhas"
  
  Scenario: when I'm not logged in
    When I go to the campaigns page
    Then I should not see "Minhas campanhas"
