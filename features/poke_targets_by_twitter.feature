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
    Then I should see "Boa!"
    And I should see "Você acaba de colaborar com uma causa que você acredita e que pode fazer a diferença para o Rio. Agora ajude a espalhar essa ideia. Não se esqueca que você pode pressionar quantas vezes quiser!"
    And a twitter poke should be added to the target
    And an email called "Valeu por apoiar a campanha: Impeça a demolição da praça Nossa Senhora da Paz" should be sent

  @omniauth_test @twitter @javascript
  Scenario: when I haven't a Twitter authorization
    Given I'm logged in
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I click "Pressionar via Twitter"
    Then I should see "Boa!"
    And I should see "Você acaba de colaborar com uma causa que você acredita e que pode fazer a diferença para o Rio. Agora ajude a espalhar essa ideia. Não se esqueca que você pode pressionar quantas vezes quiser!"
    And a tweet poke should be added to the target
    And an email called "Valeu por apoiar a campanha: Impeça a demolição da praça Nossa Senhora da Paz" should be sent

  @omniauth_test @twitter @javascript
  Scenario: when I'm not logged in
    Given there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I click "Pressionar via Twitter"
    Then I should see "Rola de fazer o login? Depois você pode continuar pressionando os alvos da campanha"
    And I should be in this campaign page
    When I click "Entrar via Facebook"
    Then I should see "Boa!"
    And I should see "Você acaba de colaborar com uma causa que você acredita e que pode fazer a diferença para o Rio. Agora ajude a espalhar essa ideia. Não se esqueca que você pode pressionar quantas vezes quiser!"
    And a tweet poke should be added to the target
    And an email called "Valeu por apoiar a campanha: Impeça a demolição da praça Nossa Senhora da Paz" should be sent
  
  @omniauth_test
  Scenario: when targets have no Twitter
    Given there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign without Twitter
    When I go to this campaign page
    Then I should not see "the Twitter poke button"
