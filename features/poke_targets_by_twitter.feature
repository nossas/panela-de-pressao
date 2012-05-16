Feature: Poke targets by Twitter
  In order to engage influencers to the campaign
  As a citizen
  I want to poke targets by Twitter

  @omniauth_test @twitter @javascript
  Scenario: when I have a Twitter authorization
    Given I'm logged in
    And I have a Twitter authorization
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I click "Pressionar via Twitter"
    Then I should see "Mais um tweet para a campanha, é isso aí! Pressão neles!"
    And a twitter poke should be added to the target

  @omniauth_test @twitter @javascript
  Scenario: when I haven't a Twitter authorization
    Given I'm logged in
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I click "Pressionar via Twitter"
    Then I should see "Mais um tweet para a campanha, é isso aí! Pressão neles!"
    And a tweet poke should be added to the target

  @omniauth_test @twitter @javascript
  Scenario: when I'm not logged in
    Given there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I click "Pressionar via Twitter"
    Then I should see "Rola de fazer o login? Depois você pode continuar pressionando os alvos da campanha"
    And I should be in the login page
    When I click "Entrar via Facebook"
    Then I should see "Mais um tweet para a campanha, é isso aí! Pressão neles!"
    And a tweet poke should be added to the target
  
  @omniauth_test
  Scenario: when targets have no Twitter
    Given there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign without Twitter
    When I go to this campaign page
    Then I should not see "the Twitter poke button"
