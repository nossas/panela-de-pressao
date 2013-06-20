Feature: edit poke message
  In order to send my message to the targets
  As an user
  I want to edit poke message

  @omniauth_test @javascript @koala
  Scenario: edit email poke message
    Given I'm logged in
    And there is a campaign called "Save the queen!"
    And there is a target for this campaign
    And I'm in this campaign page
    And I click "ver/personalizar email"
    And I fill "Mensagem" with "A rainha precisa da gente!"
    When I press "Pressionar por Email" at "the email poke message"
    Then I should see the successful poke message
    And a email poke should be added to the target
    And a email saying "A rainha precisa da gente!" should be sent

  @omniauth_test @javascript @koala
  Scenario: edit facebook poke message
    Given I'm logged in
    And there is a campaign called "Save the queen!"
    And there is a target for this campaign
    And I already poked this campaign
    And I'm in this campaign page
    And I click "ver/personalizar mensagem"
    And I fill "Mensagem" with "A rainha precisa da gente!"
    When I press "Pressionar pelo Facebook" at "the facebook poke message"
    Then I should see the successful poke message
    And a facebook poke should be added to the target
