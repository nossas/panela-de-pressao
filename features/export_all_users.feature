Feature: export all users
  In order to send an email to everybody
  As an admin
  I want to export all users

  @omniauth_test @javascript
  Scenario: when I'm an admin
    Given I'm logged in as admin
    And I'm in the campaigns page
    When I open my profile options
    Then I should see "Exportar"

  @omniauth_test @javascript
  Scenario: when I'm not an admin
    Given I'm logged in
    And I'm in the campaigns page
    When I open my profile options
    Then I should not see "Exportar"
