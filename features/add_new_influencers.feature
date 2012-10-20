Feature: Add new influencers
  In order to provide more targets to the campaigns
  As an admin
  I want to add new influencers

  @omniauth_test @koala
  Scenario: when I fill all the required fields
    Given I'm logged in as admin
    And I'm in the new influencer page
    And I fill "Nome" with "Eduardo Paes"
    And I fill "Descrição" with "Prefeito"
    And I attach an image to "Avatar"
    And I fill "Email" with "eduardopaes@meurio.org.br"
    And I fill "Twitter" with "@eduardopaes_"
    And I fill "Facebook" with "http://www.facebook.com/eduardopaesRJ"
    When I press "Adicionar alvo"
    Then I should see "Eduardo Paes"

  @omniauth_test
  Scenario: when I leave all fields blank
    Given I'm logged in as admin
    And I'm in the new influencer page
    When I press "Adicionar alvo"
    Then I should see "não pode ficar em branco"

  @omniauth_test @javascript @koala
  Scenario: when I'm not logged in
    When I go to the new influencer page
    Then I should be in the homepage
