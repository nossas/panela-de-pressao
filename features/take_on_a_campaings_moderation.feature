Feature: take on a campaing's moderation

  @omniauth_test @ssi @javascript
  Scenario: when I'm an admin
    Given there is an unmoderated campaign called "Save the whales!"
    And I'm logged in as admin
    And I go to "this campaign page"
    And I open the campaign menu
    When I click "the take on moderation button"
    Then I should be in "this campaign page"
    And I should see "me as the moderator of this campaign"
