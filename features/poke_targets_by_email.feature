Feature: Poke targets by email
  In order to engage influencers to the campaign
  As a citizen
  I want to poke targets by email

  @omniauth_test
  Scenario: when I'm logged in
    Given I'm logged in
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target with email for this campaign
    And I'm in this campaign page
    When I press "Email"
    Then I should see "1 email"
    And an email should be sent
