Feature: export users by campaign
  In order to send an email to a campaign pokers
  As an admin
  I want to export users by campaign

  @omniauth_test
  Scenario: when I'm admin
    Given I'm logged in as admin
    And there is a campaign called "Salve a Amazônia"
    When I go to this campaign page
    Then I should see "Exportar"

  Scenario: when I'm not admin
    Given there is a campaign called "Salve a Amazônia"
    When I go to this campaign page
    Then I should not see "Exportar"
