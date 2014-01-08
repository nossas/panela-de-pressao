Feature: Enable voice call integration of campaign 
  In order to allow people to connect directly with their representatives
  As an admin
  I want to enable voice call integration

  @omniauth_test @ssi
  Scenario: when I own a campaign
    Given I'm logged in
    When I'm in the new campaign page
    Then I should not see "the Plivo integration fields"
 
  @omniauth_test @ssi
  Scenario: when I'm admin
    Given I'm logged in as admin
    When I'm in the new campaign page
    Then I should see "the Plivo integration fields"
   
  @omniauth_test @javascript @bitly @ssi
  Scenario: when I'm smart enough to successfully fill the new campaign form
    Given I'm logged in as admin
    And I'm in the new campaign page
    And I fill "Escreva o nome da sua mobilização (um título curto é sempre melhor)" with "Evitar que desapareçam com a praça Nossa Senhora da Paz"
    And I fill "Descreva o problema e a solução que você quer para ele ('a paz mundial' é coisa de miss - seja específico!)" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I fill "Escreva o email que será enviado para o(s) alvo(s) cada vez que alguém pressionar" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I fill "Script que deve ser lido para quem liga" with "Script with"
    And I fill "Número que receberá as ligações" with "2197137471"
    And I attach an image to "Uma imagem que fale por mil palavras: escolha uma no seu computador e suba ela aqui"
    And I select "Educação" for "Escolha o tema da sua mobilização (ajude as pessoas encontrarem a sua mobilização)"
    When I press "Criar campanha"
    Then I should be in "the created campaign page"
    And an email called "A sua mobilização está no ar!" should be sent
