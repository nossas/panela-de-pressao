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
    And I fill "CNPJ" with "00.000.000/0000-10"
    And I fill "Endereço" with "Rua do Russel"
    When I press "Registrar minha organização"
    Then I should see "O registro da sua organização tem de ser validado, aguarde nosso contato."
