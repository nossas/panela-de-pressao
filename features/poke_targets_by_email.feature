Feature: Poke targets by email
  In order to engage influencers to the campaign
  As a citizen
  I want to poke targets by email

  @omniauth_test @javascript
  Scenario: when I'm logged in
    Given I'm logged in
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I click "Pressionar via email"
    Then I should see "Boa!"
    And I should see "Você acaba de colaborar com uma causa que você acredita e que pode fazer a diferença para o Rio. Agora ajude a espalhar essa ideia. Não se esqueca que você pode pressionar quantas vezes quiser!"
    And a email poke should be added to the target
    And an email called "Impeça a demolição da praça Nossa Senhora da Paz" should be sent
    And an email called "Valeu por apoiar a campanha: Impeça a demolição da praça Nossa Senhora da Paz" should be sent

  @omniauth_test @javascript
  Scenario: when I'm not logged in
    Given there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I click "Pressionar via email"
    Then I should see "Rola de fazer o login? Depois você pode continuar pressionando os alvos da campanha"
    And I should be in this campaign page
    When I click "Entrar via Facebook"
    Then an email called "Impeça a demolição da praça Nossa Senhora da Paz" should be sent
    And an email called "Valeu por apoiar a campanha: Impeça a demolição da praça Nossa Senhora da Paz" should be sent
    And a email poke should be added to the target
    Then I should see "Boa!"
    And I should see "Você acaba de colaborar com uma causa que você acredita e que pode fazer a diferença para o Rio. Agora ajude a espalhar essa ideia. Não se esqueca que você pode pressionar quantas vezes quiser!"

  @omniauth_test @javascript
  Scenario: when I poke a campaign twice
    Given I'm logged in
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I already poked this campaign
    And I'm in this campaign page
    When I click "Pressionar via email"
    Then an email called "Valeu por apoiar a campanha: Impeça a demolição da praça Nossa Senhora da Paz" should be sent once

  @omniauth_test
  Scenario: when there is no email to target
    Given I'm logged in
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    When I'm in this campaign page
    Then I should not see "the email poke form"
