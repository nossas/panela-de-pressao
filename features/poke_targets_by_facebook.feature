Feature: Poke targets by Facebook
  In order to engage influencers to the campaign
  As a citizen
  I want to poke targets by Facebook

  @omniauth_test @koala @javascript
  Scenario: when I have a Facebook authorization
    Given I'm logged in
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I click "Pressionar via Facebook"
    Then I should see "Uma nova mensagem foi postada no seu mural do Facebook, é isso aí! Pressão neles!"
    And a facebook poke should be added to the target

  @omniauth_test @koala @javascript
  Scenario: when I don't have a Facebook authorization
    Given I'm logged in with Meu Rio
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I click "Pressionar via Facebook"
    Then I should see "Uma nova mensagem foi postada no seu mural do Facebook, é isso aí! Pressão neles!"
    And a facebook poke should be added to the target
    
  @omniauth_test @koala @javascript
  Scenario: when I'm not logged in
    Given there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I click "Pressionar via Facebook"
    Then I should see "Rola de fazer o login? Depois você pode continuar pressionando os alvos da campanha"
    And I should be in the login page
    When I click "Entrar via Facebook"
    Then I should see "Uma nova mensagem foi postada no seu mural do Facebook, é isso aí! Pressão neles!"
    And a facebook poke should be added to the target

  @omniauth_test
  Scenario: when targets have no Facebook
    Given there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign without Facebook
    When I go to this campaign page
    Then I should not see "the Facebook poke button"
