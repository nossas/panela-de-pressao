Feature: Poke targets by email
  In order to engage influencers to the campaign
  As a citizen
  I want to poke targets by email

  @omniauth_test @javascript @koala
  Scenario: when I'm logged in
    Given I'm logged in
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I press "Pressione por e-mail"
    Then I should see "Muito bom! Você acaba de colocar mais pressão nessa panela."
    And a email poke should be added to the target
    And an email called "Impeça a demolição da praça Nossa Senhora da Paz" should be sent
    And an email called "Valeu por apoiar a campanha: Impeça a demolição da praça Nossa Senhora da Paz" should be sent

  @javascript @koala
  Scenario: when I'm not logged in
    Given there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    And I fill "Nome" with "Nícolas"
    And I fill "E-mail" with "test@paneladepressao.org.br"
    When I press "Pressione por e-mail"
    Then I should see "Muito bom! Você acaba de colocar mais pressão nessa panela."
    And a email poke should be added to the target
    And an email called "Impeça a demolição da praça Nossa Senhora da Paz" should be sent
    And an email called "Valeu por apoiar a campanha: Impeça a demolição da praça Nossa Senhora da Paz" should be sent

  @javascript @koala
  Scenario: when I'm not logged in and I miss the form
    Given there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I'm in this campaign page
    When I press "Pressione por e-mail"
    Then I should see "Não foi possível realizar a pressão :("
