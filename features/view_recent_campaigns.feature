Feature: View recent campaigns
  In order to discover new campaigns
  As a visitor
  I want to view recent campaigns

  Scenario: when there is one campaign
    Given there is a campaign called "Desarmamento Voluntário"
    When I go to the campaigns page
    Then I should see "Desarmamento Voluntário"
  
  Scenario: when there is an unmoderated campaign
    Given there is a unmoderated campaign called "Desarmamento Voluntário"
    When I go to the campaigns page
    Then I should see "Desarmamento Voluntário"
