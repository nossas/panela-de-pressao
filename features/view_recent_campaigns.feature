Feature: View recent campaigns
  In order to discover new campaigns
  As a visitor
  I want to view recent campaigns

  Scenario: when there is no campaign
    Given I'm in the campaigns page
    Then I should see "Que isso? Nenhuma campanha?!"
