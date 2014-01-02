Feature: take on a campaign's moderation

  @omniauth_test @javascript @ssi
  Scenario: when I'm an admin
    Given there is an unmoderated campaign called "Save the whales!"
    And I'm logged in as admin
    And I go to the campaigns page
    And I open my profile options
    And I click "Moderar campanhas"
    When I click "Assumir moderação"
    Then I should be in the unmoderated campaigns page
    And I should not see "Save the whales!"
    And I go to this campaign page
    And I should see "the campaign's moderator"