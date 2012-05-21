Feature: Create my own campaign
  In order to mobilize people to my cause
  As a mobilizer
  I want to create my own campaign

  @omniauth_test @bitly
  Scenario: when I'm smart enough to successfully fill the new campaign form
    Given I'm logged in
    And I'm in the new campaign page
    And I fill "O que você quer mudar na sua cidade?" with "Evitar que desapareçam com a praça Nossa Senhora da Paz"
    And I fill "Porque essa campanha é importante?" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I attach an image to "Imagem da campanha"
    And I select "Educação" for "Qual o tema da sua campanha?"
    When I press "Enviar campanha para moderação"
    Then I should be in the campaigns page
    And I should see "Aí! Recebemos a sua campanha. Em breve entraremos em contato para colocá-la no ar..."
  
  @omniauth_test @bitly
  Scenario: When I'm smart enough to successfully fill the new campaign form that has an organization as co-creator/partner
    Given I'm logged in
    And I've created an organization called "MeuRio"
    And I'm in the new campaign page
    And I fill "O que você quer mudar na sua cidade?" with "Evitar que desapareçam com a praça Nossa Senhora da Paz"
    And I fill "Porque essa campanha é importante?" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I attach an image to "Imagem da campanha"
    And I select "Educação" for "Qual o tema da sua campanha?"
    And I select "MeuRio" for "Quem está por trás?"
    When I press "Enviar campanha para moderação"
    Then I should be in the campaigns page
    And I should see "Aí! Recebemos a sua campanha. Em breve entraremos em contato para colocá-la no ar..."   

  @omniauth_test @bitly
  Scenario: when I'm not logged in
    Given I'm in the campaigns page
    And I click "Crie a sua campanha"
    Then I should be in the login page
    And I should see "Rola de fazer o login? Depois você pode continuar criando a sua campanha ;)"
    Given I click "Entrar via Facebook"
    And I fill "O que você quer mudar na sua cidade?" with "Evitar que desapareçam com a praça Nossa Senhora da Paz"
    And I fill "Porque essa campanha é importante?" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I attach an image to "Imagem da campanha"
    And I select "Educação" for "Qual o tema da sua campanha?"
    When I press "Enviar campanha para moderação"
    Then I should be in the campaigns page
    And I should see "Aí! Recebemos a sua campanha. Em breve entraremos em contato para colocá-la no ar..."

  @omniauth_test
  Scenario: when I'm troll enough to let all fields blank
    Given I'm logged in
    And I'm in the new campaign page
    When I press "Enviar campanha para moderação"
    Then I should see "Queremos saber o que você quer mudar na sua cidade!"
    And I should see "Para uma campanha existir ela tem que ter um propósito! Porque essa campanha é importante?"
