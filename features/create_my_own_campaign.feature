Feature: Create my own campaign
  In order to mobilize people to my cause
  As a mobilizer
  I want to create my own campaign

  Background:
    Given there is an organization in "Rio de Janeiro"
    And there is an influencer called "Eduardo Paes"

  @omniauth_test @javascript @bitly
  Scenario: when I'm smart enough to successfully fill the new campaign form
    Given I'm logged in
    And I'm in the new campaign page
    And I fill "Escreva o nome da sua mobilização (um título curto é sempre melhor)" with "Evitar que desapareçam com a praça Nossa Senhora da Paz"
    And I select "Rio de Janeiro" for "Escolha uma cidade para a sua mobilização"
    And I fill "Descreva o problema e a solução que você quer para ele ('a paz mundial' é coisa de miss - seja específico!)" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I fill "Escreva o email que será enviado para o(s) alvo(s) cada vez que alguém pressionar" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I attach an image to "Uma imagem que fale por mil palavras: escolha uma no seu computador e suba ela aqui"
    And I select "Educação" for "Escolha a categoria da sua mobilização (ajude as pessoas encontrarem a sua mobilização)"
    And I fill "Escreva o título do compartilhamento (ele será publicado nas páginas de Face daqueles que compartilharem)" with "Ajude a praça Nossa Senhora da Paz!"
    And I fill "Escreva o texto do compartilhamento (será publicado logo abaixo do título aí de cima)" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I attach an image to "Escolha uma imagem do seu computador (será publicada junto com o título e o texto)"
    And I select "Eduardo Paes" as a target
    When I press "Criar campanha"
    Then I should be in "the created campaign page"
    And an email called "A sua mobilização está no ar!" should be sent
    And an email called "Nova campanha no Panela de Pressão (Rio de Janeiro)" should be sent
    And the organization from "Rio de Janeiro" should have 1 campaign now

  @omniauth_test @javascript @bitly
  Scenario: when I'm not logged in
    Given I'm in the campaigns page
    When I click "the new campaign button"
    Then I should be in "the Meu Rio accounts login page"

  @omniauth_test @javascript
  Scenario: when I'm troll enough to let all fields blank
    Given I'm logged in
    And I'm in the new campaign page
    When I press "Criar campanha"
    Then I should see "Queremos saber o que você quer mudar na sua cidade!"
    And I should see "Para uma campanha existir ela tem que ter um propósito! Porque essa campanha é importante?"

  @omniauth_test @javascript @bitly
  Scenario: when I leave mobile phone empty
    Given I'm logged in
    And I have no phone
    And I'm in the campaigns page
    And I click "the new campaign button"
    And I fill "Escreva o nome da sua mobilização (um título curto é sempre melhor)" with "Evitar que desapareçam com a praça Nossa Senhora da Paz"
    And I fill "Descreva o problema e a solução que você quer para ele ('a paz mundial' é coisa de miss - seja específico!)" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I fill "Escreva o email que será enviado para o(s) alvo(s) cada vez que alguém pressionar" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I attach an image to "Uma imagem que fale por mil palavras: escolha uma no seu computador e suba ela aqui"
    And I select "Educação" for "Escolha a categoria da sua mobilização (ajude as pessoas encontrarem a sua mobilização)"
    And I select "Eduardo Paes" as a target
    When I press "Criar campanha"
    Then I should see "Precisamos do seu celular para que a equipe de curadoria possa entrar em contato."

  @omniauth_test
  Scenario: when I'm an admin
    Given I'm logged in as admin
    When I click "the new campaign button"
    Then I should see the campaign's hashtag field

  @omniauth_test
  Scenario: when I'm not an admin
    Given I'm logged in
    When I click "the new campaign button"
    Then I should not see the campaign's hashtag field
