Feature: Create an Organization
  In order to associate my campaigns with the organization I belong to
  as an mobilizer
  I want to create an organization

  @omniauth_test
  Scenario: I'm logged and I want to register an organization and wait for approval
    Given I'm logged in
    And I'm in the campaigns page
    And I click "Criar uma organização"
    And I fill "Nome" with "MeuRio"
    And I attach an image to "Avatar"
    When I press "Cadastrar organização"
    Then I should see "Sua organização foi criada! Que tal criar campanhas envolvendo usa organização?"
