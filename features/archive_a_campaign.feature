Feature: archive a campaign

  @omniauth_test @ssi
  Scenario: when I'm an admin
    Given I'm logged in as admin
    And there is a campaign
    And I go to "this campaign page"
    When I click "the archive campaign button"
    Then I should be in this campaign page
    And I should see "Essa campanha foi arquivada"
