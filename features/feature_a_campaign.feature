Feature: Put a campaign on featured mode
  In order to allow a campaign to be highlighted
  As an admin
  I want to feature a campaign

  @omniauth_test @javascript @ssi
  Scenario: I'm logged in as admin
    Given I'm logged in as admin
    And there is a campaign called "Save the Whales!"
    And I'm in this campaign page
    And I open the campaign menu
    When I click "the feature button"
    Then I should be in this campaign page
