Feature: edit a campaign
  In order to change a campaign
  As an admin
  I want to edit a campaign

  @omniauth_test
  Scenario: when I'm admin
    Given I'm logged in as admin
    And there is a campaign called "Salve a praça Nossa Senhora da Paz"
    And I'm in the campaigns page
    And I click "Salve a praça Nossa Senhora da Paz"
    And I click "Editar campanha"
    Then I should not see "the accept campaign button"
    Given I fill "Qual é o título da sua campanha?" with "Fim à Escravidão no Brasil"
    When I press "Salvar campanha"
    Then I should be in this campaign page
    And I should see "Fim à Escravidão no Brasil"
    And no email called "Sua campanha foi aprovada!" should be sent

  @omniauth_test
  Scenario: when I'm not admin
    Given I'm logged in
    And there is a campaign called "Salve a praça Nossa Senhora da Paz"
    And I'm in the campaigns page
    When I click "Salve a praça Nossa Senhora da Paz"
    Then I should not see "the edit campaign button"

  @omniauth_test
  Scenario: when I'm the campaign's owner
    Given I'm logged in
    And I own a campaign called "Salve a praça Nossa Senhora da Paz"
    And I'm in this campaign page
    And I click "Editar campanha"
    Then I should not see "the accept campaign button"
    Given I fill "Qual é o título da sua campanha?" with "Fim à Escravidão no Brasil"
    When I press "Salvar campanha"
    Then I should be in this campaign page
    And I should see "Fim à Escravidão no Brasil"
    And no email called "Sua campanha foi aprovada!" should be sent
