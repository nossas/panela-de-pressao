Feature: take on a campaign's moderation

  @omniauth_test
  Scenario: when I'm an admin
    Given there is an unmoderated campaign called "Save the whales!"
    And I'm logged in as admin
    And I go to the unmoderated campaigns page
    When I click "Assumir moderação"
    Then I should be in the unmoderated campaigns page
    And I should see "the campaign's moderator name" in "the campaign list"
