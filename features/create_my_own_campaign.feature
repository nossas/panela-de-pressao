Feature: Create my own campaign
  In order to mobilize people to my cause
  As a mobilizer
  I want to create my own campaign

  @omniauth_test @javascript @bitly @ssi
  Scenario: when I'm smart enough to successfully fill the new campaign form
    Given I'm logged in
    And I'm in the new campaign page
    And I fill "Escreva o nome da sua mobilização (um título curto é sempre melhor)" with "Evitar que desapareçam com a praça Nossa Senhora da Paz"
    And I fill "Descreva o problema e a solução que você quer para ele ('a paz mundial' é coisa de miss - seja específico!)" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I fill "Escreva o email que será enviado para o(s) alvo(s) cada vez que alguém pressionar" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I attach an image to "Uma imagem que fale por mil palavras: escolha uma no seu computador e suba ela aqui"
    And I select "Educação" for "Escolha o tema da sua mobilização (ajude as pessoas encontrarem a sua mobilização)"
    And I fill "Escreva o título do compartilhamento (ele será publicado nas páginas de Face daqueles que compartilharem)" with "Ajude a praça Nossa Senhora da Paz!"
    And I fill "Escreva o texto do compartilhamento (será publicado logo abaixo do título aí de cima)" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I attach an image to "Escolha uma imagem do seu computador (será publicada junto com o título e o texto)"
    When I press "Criar campanha"
    Then I should be in "the created campaign page"
    And an email called "A sua mobilização está no ar!" should be sent
  
  @omniauth_test @javascript @bitly
  Scenario: when I'm not logged in
    Given I'm in the campaigns page
    When I click "the new campaign button"
    Then I should be in "the Meu Rio accounts login page"

  @omniauth_test @ssi
  Scenario: when I'm troll enough to let all fields blank
    Given I'm logged in
    And I'm in the new campaign page
    When I press "Criar campanha"
    Then I should see "Queremos saber o que você quer mudar na sua cidade!"
    And I should see "Para uma campanha existir ela tem que ter um propósito! Porque essa campanha é importante?"

  @omniauth_test @javascript @bitly @ssi
  Scenario: when I leave mobile phone empty
    Given I'm logged in
    And I have no phone
    And I'm in the campaigns page
    And I click "the new campaign button"
    And I fill "Escreva o nome da sua mobilização (um título curto é sempre melhor)" with "Evitar que desapareçam com a praça Nossa Senhora da Paz"
    And I fill "Descreva o problema e a solução que você quer para ele ('a paz mundial' é coisa de miss - seja específico!)" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I fill "Escreva o email que será enviado para o(s) alvo(s) cada vez que alguém pressionar" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I attach an image to "Uma imagem que fale por mil palavras: escolha uma no seu computador e suba ela aqui"
    And I select "Educação" for "Escolha o tema da sua mobilização (ajude as pessoas encontrarem a sua mobilização)"
    When I press "Criar campanha"
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
