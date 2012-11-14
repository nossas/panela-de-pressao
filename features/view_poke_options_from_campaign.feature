Feature: View poke options
  In order to poke influencers
  As a citizen
  I want to poke using email, twitter or facebook

  @javascript @omniauth_test
  Scenario: View enabled poke options from targets with only email
    Given I'm logged in
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is one target for this campaign without Facebook and without Twitter
    When I'm in this campaign page
    Then I should not see "mensagem será publicada no mural do alvo"
    And I should not see "mensagem será publicada no perfil do alvo"
    And I should see "mensagem será enviada ao e-mail do alvo"

  @javascript @omniauth_test
  Scenario: View enabled poke options when targets have email, twitter and facebook
    Given I'm logged in
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    When I'm in this campaign page
    Then I should see "mensagem será publicada no mural do alvo"
    And I should see "mensagem será publicada no perfil do alvo"
    And I should see "mensagem será enviada ao e-mail do alvo"
