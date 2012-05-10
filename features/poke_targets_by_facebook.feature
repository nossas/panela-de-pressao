Feature: Poke targets by Facebook
  In order to engage influencers to the campaign
  As a citizen
  I want to poke targets by Facebook

  @omniauth_test @koala
  Scenario: when I have a Facebook authorization
    Given I'm logged in
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I press "Via Facebook"
    Then I should see "1 pessoa já compartilhou"
    And a facebook poke should be added to the target
    And I should see "Uma nova mensagem foi postada no seu mural do Facebook, é isso aí! Pressão neles!"

  @omniauth_test @koala
  Scenario: when I don't have a Facebook authorization
    Given I'm logged in with Meu Rio
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I press "Via Facebook"
    Then I should see "1 pessoa já compartilhou"
    And a facebook poke should be added to the target
    And I should see "Uma nova mensagem foi postada no seu mural do Facebook, é isso aí! Pressão neles!"

  @omniauth_test @koala
  Scenario: when I'm not logged in
    Given there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I press "Via Facebook"
    Then I should be in the login page
    When I click "Entrar via Facebook"
    Then I should see "1 pessoa já compartilhou"
    And a facebook poke should be added to the target
    And I should see "Uma nova mensagem foi postada no seu mural do Facebook, é isso aí! Pressão neles!"

  @omniauth_test
  Scenario: when targets have no Facebook
    Given there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign without Facebook
    When I go to this campaign page
    Then I should not see "the Facebook poke button"
    And I should not see "ninguém compartilhou ainda"
