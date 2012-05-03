Feature: Poke targets by email
  In order to engage influencers to the campaign
  As a citizen
  I want to poke targets by email

  @omniauth_test
  Scenario: when I'm logged in
    Given I'm logged in
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I press "Email"
    Then I should see "1 email já foi enviado"
    And an email should be sent
    And an email poke should be added to the target
    And I should see "Seu email foi enviado aos alvos da campanha, é isso aí! Pressão neles!"

  @omniauth_test
  Scenario: when I'm not logged in
    Given there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I press "Email"
    Then I should be in the login page
    And I should see "Rola de fazer o login? Depois você pode continuar pressionando os alvos da campanha"
    When I click "Entrar via Facebook"
    Then I should see "1 email"
    And an email should be sent
    And an email poke should be added to the target
    And I should see "Agora sim, seu email foi enviado aos alvos da campanha! Pressão neles!"

  @omniauth_test
  Scenario: when there is no email to target
    Given I'm logged in
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    When I'm in this campaign page
    Then I should not see "nenhum email"
