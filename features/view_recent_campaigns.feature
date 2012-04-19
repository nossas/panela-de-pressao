Feature: View recent campaigns
  In order to discover new campaigns
  As a visitor
  I want to view recent campaigns

  Scenario: when there is no campaign
    Given I'm in the campaigns page
    Then I should see "Que isso? Nenhuma campanha?!"

  Scenario: when there is one campaign
    Given there is a campaign called "Desarmamento Voluntário"
    When I go to the campaigns page
    Then I should see "Desarmamento Voluntário"
  
  Scenario: when there is more than one campaign
    Given there is a campaign called "Desarmamento Voluntário" accepted on "1/1/2012"
    And there is a campaign called "Preservação da Praça XV de Novembro" accepted on "2/1/2012"
    When I go to the campaigns page
    Then I should see "Preservação da Praça XV de Novembro" before "Desarmamento Voluntário"
