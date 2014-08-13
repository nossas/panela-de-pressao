Feature: export users by campaign
  In order to send an email to a campaign pokers
  As an admin
  I want to export users by campaign

  @omniauth_test @javascript
  Scenario: when I'm admin
    Given I'm logged in as admin
    And there is a campaign called "Salve a Amazônia"
    And I go to "this campaign page"
    When I open the campaign menu
    Then I should see "the export users button"

  Scenario: when I'm admin
    Given I'm logged in as admin
    And there is a campaign called "Salve a Amazônia"
    When I go to "this campaign export users page"
    Then a CSV file should be downloaded

  Scenario: when I'm not admin
    Given there is a campaign called "Salve a Amazônia"
    When I go to "this campaign page"
    Then I should not see "the campaign menu"
