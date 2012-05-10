Feature: Poke targets by Facebook
  In order to engage influencers to the campaign
  As a citizen
  I want to poke targets by Facebook

  @omniauth_test @koala
  Scenario: when I'm logged in with my Facebook account
    Given I'm logged in
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I press "Via Facebook"
    Then I should see "1 pessoa já compartilhou"
    And a facebook poke should be added to the target
    And I should see "Uma nova mensagem foi postada no seu mural do Facebook, é isso aí! Pressão neles!"

  @omniauth_test @koala
  Scenario: when I'm logged in with my Meu Rio account
    Given I'm logged in with Meu Rio
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I press "Via Facebook"
    Then I should see "1 pessoa já compartilhou"
    And a facebook poke should be added to the target
    And I should see "Uma nova mensagem foi postada no seu mural do Facebook, é isso aí! Pressão neles!"
