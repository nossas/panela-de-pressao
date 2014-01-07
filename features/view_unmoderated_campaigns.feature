Feature: View unmoderated campaigns
  In order to choose a campaign to moderate
  As an admin
  I want to view the unmoderated campaigns

  @omniauth_test @javascript @ssi
  Scenario: when I'm an admin
    Given there is an unmoderated campaign called "Save the whales!"
    And I'm logged in as admin
    And I go to "the campaigns page"
    And I open my profile options
    When I click "the unmoderated campaigns button"
    Then I should be in "the unmoderated campaigns page"
    And I should see "the unmoderated campaign"

  @omniauth_test @javascript @ssi
  Scenario: when the campaign already has a moderator
    Given there is a campaign called "Save the whales!" moderated by "Jack Daniel"
    And I'm logged in as admin
    And I go to "the campaigns page"
    And I open my profile options
    When I click "the unmoderated campaigns button"
    Then I should not see "Save the whales!"
