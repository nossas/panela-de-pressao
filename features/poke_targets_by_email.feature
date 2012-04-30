Feature: Poke targets by email
  In order to engage influencers to the campaign
  As a citizen
  I want to poke targets by email

  Scenario: when I'm not logged in
    Given there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target with email for this campaign
    And I'm in this campaign page
    And I press "Cutucar por email"
    When I click "Entrar via Facebook"
    Then I should see "1 pessoa cutucou os alvos por email"
