Feature: Poke targets by Twitter
  In order to engage influencers to the campaign
  As a citizen
  I want to poke targets by Twitter

  @omniauth_test @twitter @javascript @koala
  Scenario: when I have a Twitter authorization
    Given I'm logged in
    And I have a Twitter authorization
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I already poked this campaign
    And I'm in this campaign page
    When I press "Pressione no twitter"
    Then I should see "Muito bom! Você acaba de colocar mais pressão nessa panela."
    And a twitter poke should be added to the target
    And an email called "Valeu por apoiar a campanha: Impeça a demolição da praça Nossa Senhora da Paz" should be sent

  @omniauth_test @twitter @javascript @koala
  Scenario: when I haven't a Twitter authorization
    Given I'm logged in
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I already poked this campaign
    And I'm in this campaign page
    When I press "Pressione no twitter"
    Then I should see "Muito bom! Você acaba de colocar mais pressão nessa panela."
    And a tweet poke should be added to the target
    And an email called "Valeu por apoiar a campanha: Impeça a demolição da praça Nossa Senhora da Paz" should be sent
