Feature: export all users
  In order to send an email to everybody
  As an admin
  I want to export all users

  @omniauth_test @javascript @ssi
  Scenario: when I'm an admin
    When I'm logged in as admin
    Then the profile panel should have an option to export all users

  @omniauth_test @javascript @ssi
  Scenario: when I'm not an admin
    When I'm logged in
    Then the profile panel should not have an option to export all users
