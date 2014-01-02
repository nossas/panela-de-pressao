Feature: take on a campaing's moderation

  @omniauth_test @ssi
  Scenario: when I'm an admin
    Given there is an unmoderated campaign called "Save the whales!"
    And I'm logged in as admin
    And I go to "the unmoderated campaigns page"
    When I click "the take on a campaign button"
    Then I should be in the unmoderated campaigns page
    And I should see "the campaign's moderator name" in "the campaign list"
