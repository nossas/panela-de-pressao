Feature: view all the pokers
  In order to know who is joined the campaign
  As a visitor
  I want to view all the pokers of a campaign

  Scenario: when there is no poker
    Given there is a campaign called "Guerreiros campeões"
    And I'm in the campaigns page
    When I click "Guerreiros campeões"
    Then I should not see "Quem já pressionou"

  Scenario: when there is a poker
    Given there is a campaign called "Guerreiros campeões"
    And there is a poker called "Marcelinho"
    When I go to this campaign page
    Then I should see "Quem está pressionando os alvos"
    And I should see "the poker avatar"
