Feature: Add new influencers
  In order to provide more targets to the campaigns
  As an admin
  I want to add new influencers

  Scenario: when I fill all the required fields
    Given I'm in the new influencer page
    And I fill "Nome" with "Eduardo Paes"
    And I fill "Cargo" with "Prefeito"
    And I attach an image to "Avatar"
    And I fill "Email" with "eduardopaes@meurio.org.br"
    And I fill "Twitter" with "eduardopaes_"
    And I fill "Facebook" with "eduardopaesRJ"
    When I press "Adicionar influenciador"
    Then I should see "Eduardo Paes"

  Scenario: when I leave all fields blank
    Given I'm in the new influencer page
    When I press "Adicionar influenciador"
    Then I should see "não pode ficar em branco"
