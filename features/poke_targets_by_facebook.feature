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
    Then I should see "Boa!"
    And I should see "Você acaba de colaborar com uma causa que você acredita e que pode fazer a diferença para o Rio. Agora ajude a espalhar essa ideia. Não se esqueca que você pode pressionar quantas vezes quiser!"
    And a facebook poke should be added to the target
    And an email called "Valeu por apoiar a campanha: Impeça a demolição da praça Nossa Senhora da Paz" should be sent

  @omniauth_test @koala @javascript
  Scenario: when I don't have a Facebook authorization
    Given I'm logged in with Meu Rio
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I click "Pressionar via Facebook"
    Then I should see "Boa!"
    And I should see "Você acaba de colaborar com uma causa que você acredita e que pode fazer a diferença para o Rio. Agora ajude a espalhar essa ideia. Não se esqueca que você pode pressionar quantas vezes quiser!"
    And a facebook poke should be added to the target
    And an email called "Valeu por apoiar a campanha: Impeça a demolição da praça Nossa Senhora da Paz" should be sent
    
  @omniauth_test @koala @javascript
  Scenario: when I'm not logged in
    Given there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I click "Pressionar via Facebook"
    Then I should see "Rola de fazer o login? Depois você pode continuar pressionando os alvos da campanha"
    And I should be in this campaign page
    When I click "Entrar via Facebook"
    Then I should see "Boa!"
    And I should see "Você acaba de colaborar com uma causa que você acredita e que pode fazer a diferença para o Rio. Agora ajude a espalhar essa ideia. Não se esqueca que você pode pressionar quantas vezes quiser!"
    And a facebook poke should be added to the target
    And an email called "Valeu por apoiar a campanha: Impeça a demolição da praça Nossa Senhora da Paz" should be sent

  @omniauth_test
  Scenario: when targets have no Facebook
    Given there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign without Facebook
    When I go to this campaign page
    Then I should not see "the Facebook poke button"

  @omniauth_test @javascript @koala
  Scenario: when I customize the poke message
    Given I'm logged in
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    And I pass over the facebook poke button
    And I fill "Você pode personalizar a sua mensagem" with "Impeça a demolição da praça Nossa Senhora da Paz"
    When I click "Pressionar via Facebook"
    Then an email called "Valeu por apoiar a campanha: Impeça a demolição da praça Nossa Senhora da Paz" should be sent
    And a facebook poke should be added to the target
    And I should see "Boa!"
    And I should see "Você acaba de colaborar com uma causa que você acredita e que pode fazer a diferença para o Rio. Agora ajude a espalhar essa ideia. Não se esqueca que você pode pressionar quantas vezes quiser!"
