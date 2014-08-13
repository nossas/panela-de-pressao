Feature: change the campaign's ownership
  In order to change the ownership of a campaign that an admin created
  As an admin
  I want to change the campaign's ownership

#  @omniauth_test @javascript @ssi
#  Scenario: when I'm an admin
#    Given there is a campaign
#    And there is an user with email "nicolas@paneladepressao.org.br"
#    And I'm logged in as admin
#    And I'm in this campaign editing page
#    And I choose "nicolas@paneladepressao.org.br" in the autocomplete
#    When I press "Salvar campanha"
#    Then the campaign's owner should be "nicolas@paneladepressao.org.br"

  @omniauth_test @ssi
  Scenario: when I'm not the admin
    Given I'm logged in
    And I own a campaign
    When I'm in this campaign editing page
    Then I should not see "the ownership field"
