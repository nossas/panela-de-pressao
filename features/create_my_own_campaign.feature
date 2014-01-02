Feature: Create my own campaign
  In order to mobilize people to my cause
  As a mobilizer
  I want to create my own campaign

  @omniauth_test @javascript @bitly @ssi
  Scenario: when I'm smart enough to successfully fill the new campaign form
    Given I'm logged in
    And I'm in the new campaign page
    And I fill "O nome da minha campanha será" with "Evitar que desapareçam com a praça Nossa Senhora da Paz"
    And I fill "A situação que eu quero mudar com ela é" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I fill "A mensagem de email que eu quero enviar para os alvos é" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I attach an image to "Para a divulgação da minha campanha bombar, vou usar essa imagem"
    And I select "Educação" for "E trata do tema"    
    And I fill "Título da pós-pressão" with "Ajude a praça Nossa Senhora da Paz!"
    And I fill "Texto da pós-pressão" with "Ajude a praça Nossa Senhora da Paz!"
    And I fill "Link da pós-pressão" with "Ajude a praça Nossa Senhora da Paz!"
    And I fill "Texto do botão da pós-pressão" with "Ajude a praça Nossa Senhora da Paz!"    
    And I fill "Título de compartilhamento no Facebook" with "Ajude a praça Nossa Senhora da Paz!"
    And I fill "Texto de compartilhamento no Facebook" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I attach an image to "Imagem de compartilhamento no Facebook"
    When I press "Enviar campanha para moderação"
    Then I should be in "the campaigns page"
    And I should see "Aí! Recebemos a sua campanha. Em breve entraremos em contato para colocá-la no ar..."
    And an email called "Recebemos a sua campanha" should be sent
    And an email called "Campanha aguardando moderação" should be sent
  
  @omniauth_test @javascript @bitly
  Scenario: when I'm not logged in
    Given I'm in the campaigns page
    When I click "the new campaign button"
    Then I should be in "the Meu Rio accounts login page"

  @omniauth_test @ssi
  Scenario: when I'm troll enough to let all fields blank
    Given I'm logged in
    And I'm in the new campaign page
    When I press "Enviar campanha para moderação"
    Then I should see "Queremos saber o que você quer mudar na sua cidade!"
    And I should see "Para uma campanha existir ela tem que ter um propósito! Porque essa campanha é importante?"

  @omniauth_test @javascript @bitly
  Scenario: when I leave mobile phone empty
    Given I'm logged in
    And I have no phone
    And I'm in the campaigns page
    And I click "the new campaign button"
    And I fill "O nome da minha campanha será" with "Evitar que desapareçam com a praça Nossa Senhora da Paz"
    And I fill "A situação que eu quero mudar com ela é" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I fill "A mensagem de email que eu quero enviar para os alvos é" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I attach an image to "Para a divulgação da minha campanha bombar, vou usar essa imagem"
    And I select "Educação" for "E trata do tema"
    When I press "Enviar campanha para moderação"
    Then I should see "Precisamos do seu celular para que a equipe de curadoria possa entrar em contato."

  @omniauth_test @ssi
  Scenario: when I'm an admin
    Given I'm logged in as admin
    When I click "the new campaign button"
    Then I should see the campaign's hashtag field

  @omniauth_test @ssi
  Scenario: when I'm not an admin
    Given I'm logged in
    When I click "the new campaign button"
    Then I should not see the campaign's hashtag field
